bss
align 4
LABELV $54
skip 4
export BotNumActivePlayers
code
proc BotNumActivePlayers 1056 12
file "../ai_chat.c"
line 48
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:/*****************************************************************************
;5: * name:		ai_chat.c
;6: *
;7: * desc:		Quake3 bot AI
;8: *
;9: * $Archive: /MissionPack/code/game/ai_chat.c $
;10: *
;11: *****************************************************************************/
;12:
;13:#include "g_local.h"
;14:#include "botlib.h"
;15:#include "be_aas.h"
;16:#include "be_ea.h"
;17:#include "be_ai_char.h"
;18:#include "be_ai_chat.h"
;19:#include "be_ai_gen.h"
;20:#include "be_ai_goal.h"
;21:#include "be_ai_move.h"
;22:#include "be_ai_weap.h"
;23://
;24:#include "ai_main.h"
;25:#include "ai_dmq3.h"
;26:#include "ai_chat.h"
;27:#include "ai_cmd.h"
;28:#include "ai_dmnet.h"
;29://
;30:#include "chars.h"				//characteristics
;31:#include "inv.h"				//indexes into the inventory
;32:#include "syn.h"				//synonyms
;33:#include "match.h"				//string matching types and vars
;34:
;35:// for the voice chats
;36:#ifdef MISSIONPACK // bk001205
;37:#include "../../ui/menudef.h"
;38:#endif
;39:
;40:#define TIME_BETWEENCHATTING	25
;41:
;42:
;43:/*
;44:==================
;45:BotNumActivePlayers
;46:==================
;47:*/
;48:int BotNumActivePlayers(void) {
line 53
;49:	int i, num;
;50:	char buf[MAX_INFO_STRING];
;51:	static int maxclients;
;52:
;53:	if (!maxclients)
ADDRGP4 $54
INDIRI4
CNSTI4 0
NEI4 $55
line 54
;54:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $57
ARGP4
ADDRLP4 1032
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $54
ADDRLP4 1032
INDIRI4
ASGNI4
LABELV $55
line 56
;55:
;56:	num = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 57
;57:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 1024
CNSTI4 0
ASGNI4
ADDRGP4 $61
JUMPV
LABELV $58
line 58
;58:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 1024
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 60
;59:		//if no config string or no name
;60:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 0
ARGP4
ADDRLP4 1036
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
EQI4 $65
ADDRLP4 0
ARGP4
ADDRGP4 $64
ARGP4
ADDRLP4 1040
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1044
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $62
LABELV $65
ADDRGP4 $59
JUMPV
LABELV $62
line 62
;61:		//skip spectators
;62:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 0
ARGP4
ADDRGP4 $68
ARGP4
ADDRLP4 1048
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1048
INDIRP4
ARGP4
ADDRLP4 1052
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 3
NEI4 $66
ADDRGP4 $59
JUMPV
LABELV $66
line 64
;63:		//
;64:		num++;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 65
;65:	}
LABELV $59
line 57
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $61
ADDRLP4 1024
INDIRI4
ADDRGP4 $54
INDIRI4
GEI4 $69
ADDRLP4 1024
INDIRI4
CNSTI4 64
LTI4 $58
LABELV $69
line 66
;66:	return num;
ADDRLP4 1028
INDIRI4
RETI4
LABELV $53
endproc BotNumActivePlayers 1056 12
bss
align 4
LABELV $71
skip 4
export BotIsFirstInRankings
code
proc BotIsFirstInRankings 1524 12
line 74
;67:}
;68:
;69:/*
;70:==================
;71:BotIsFirstInRankings
;72:==================
;73:*/
;74:int BotIsFirstInRankings(bot_state_t *bs) {
line 80
;75:	int i, score;
;76:	char buf[MAX_INFO_STRING];
;77:	static int maxclients;
;78:	playerState_t ps;
;79:
;80:	if (!maxclients)
ADDRGP4 $71
INDIRI4
CNSTI4 0
NEI4 $72
line 81
;81:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $57
ARGP4
ADDRLP4 1500
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $71
ADDRLP4 1500
INDIRI4
ASGNI4
LABELV $72
line 83
;82:
;83:	score = bs->cur_ps.persistant[PERS_SCORE];
ADDRLP4 1496
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
ASGNI4
line 84
;84:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $77
JUMPV
LABELV $74
line 85
;85:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 87
;86:		//if no config string or no name
;87:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 4
ARGP4
ADDRLP4 1504
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1504
INDIRI4
CNSTI4 0
EQI4 $80
ADDRLP4 4
ARGP4
ADDRGP4 $64
ARGP4
ADDRLP4 1508
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1508
INDIRP4
ARGP4
ADDRLP4 1512
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1512
INDIRI4
CNSTI4 0
NEI4 $78
LABELV $80
ADDRGP4 $75
JUMPV
LABELV $78
line 89
;88:		//skip spectators
;89:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 4
ARGP4
ADDRGP4 $68
ARGP4
ADDRLP4 1516
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1516
INDIRP4
ARGP4
ADDRLP4 1520
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1520
INDIRI4
CNSTI4 3
NEI4 $81
ADDRGP4 $75
JUMPV
LABELV $81
line 91
;90:		//
;91:		BotAI_GetClientState(i, &ps);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1028
ARGP4
ADDRGP4 BotAI_GetClientState
CALLI4
pop
line 92
;92:		if (score < ps.persistant[PERS_SCORE]) return qfalse;
ADDRLP4 1496
INDIRI4
ADDRLP4 1028+248
INDIRI4
GEI4 $83
CNSTI4 0
RETI4
ADDRGP4 $70
JUMPV
LABELV $83
line 93
;93:	}
LABELV $75
line 84
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $77
ADDRLP4 0
INDIRI4
ADDRGP4 $71
INDIRI4
GEI4 $86
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $74
LABELV $86
line 94
;94:	return qtrue;
CNSTI4 1
RETI4
LABELV $70
endproc BotIsFirstInRankings 1524 12
bss
align 4
LABELV $88
skip 4
export BotIsLastInRankings
code
proc BotIsLastInRankings 1524 12
line 102
;95:}
;96:
;97:/*
;98:==================
;99:BotIsLastInRankings
;100:==================
;101:*/
;102:int BotIsLastInRankings(bot_state_t *bs) {
line 108
;103:	int i, score;
;104:	char buf[MAX_INFO_STRING];
;105:	static int maxclients;
;106:	playerState_t ps;
;107:
;108:	if (!maxclients)
ADDRGP4 $88
INDIRI4
CNSTI4 0
NEI4 $89
line 109
;109:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $57
ARGP4
ADDRLP4 1500
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $88
ADDRLP4 1500
INDIRI4
ASGNI4
LABELV $89
line 111
;110:
;111:	score = bs->cur_ps.persistant[PERS_SCORE];
ADDRLP4 1496
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
ASGNI4
line 112
;112:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $94
JUMPV
LABELV $91
line 113
;113:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 115
;114:		//if no config string or no name
;115:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 4
ARGP4
ADDRLP4 1504
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1504
INDIRI4
CNSTI4 0
EQI4 $97
ADDRLP4 4
ARGP4
ADDRGP4 $64
ARGP4
ADDRLP4 1508
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1508
INDIRP4
ARGP4
ADDRLP4 1512
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1512
INDIRI4
CNSTI4 0
NEI4 $95
LABELV $97
ADDRGP4 $92
JUMPV
LABELV $95
line 117
;116:		//skip spectators
;117:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 4
ARGP4
ADDRGP4 $68
ARGP4
ADDRLP4 1516
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1516
INDIRP4
ARGP4
ADDRLP4 1520
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1520
INDIRI4
CNSTI4 3
NEI4 $98
ADDRGP4 $92
JUMPV
LABELV $98
line 119
;118:		//
;119:		BotAI_GetClientState(i, &ps);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1028
ARGP4
ADDRGP4 BotAI_GetClientState
CALLI4
pop
line 120
;120:		if (score > ps.persistant[PERS_SCORE]) return qfalse;
ADDRLP4 1496
INDIRI4
ADDRLP4 1028+248
INDIRI4
LEI4 $100
CNSTI4 0
RETI4
ADDRGP4 $87
JUMPV
LABELV $100
line 121
;121:	}
LABELV $92
line 112
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $94
ADDRLP4 0
INDIRI4
ADDRGP4 $88
INDIRI4
GEI4 $103
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $91
LABELV $103
line 122
;122:	return qtrue;
CNSTI4 1
RETI4
LABELV $87
endproc BotIsLastInRankings 1524 12
bss
align 1
LABELV $105
skip 32
align 4
LABELV $106
skip 4
export BotFirstClientInRankings
code
proc BotFirstClientInRankings 1528 12
line 130
;123:}
;124:
;125:/*
;126:==================
;127:BotFirstClientInRankings
;128:==================
;129:*/
;130:char *BotFirstClientInRankings(void) {
line 137
;131:	int i, bestscore, bestclient;
;132:	char buf[MAX_INFO_STRING];
;133:	static char name[32];
;134:	static int maxclients;
;135:	playerState_t ps;
;136:
;137:	if (!maxclients)
ADDRGP4 $106
INDIRI4
CNSTI4 0
NEI4 $107
line 138
;138:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $57
ARGP4
ADDRLP4 1504
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $106
ADDRLP4 1504
INDIRI4
ASGNI4
LABELV $107
line 140
;139:
;140:	bestscore = -999999;
ADDRLP4 1496
CNSTI4 -999999
ASGNI4
line 141
;141:	bestclient = 0;
ADDRLP4 1500
CNSTI4 0
ASGNI4
line 142
;142:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $112
JUMPV
LABELV $109
line 143
;143:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 145
;144:		//if no config string or no name
;145:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 4
ARGP4
ADDRLP4 1508
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1508
INDIRI4
CNSTI4 0
EQI4 $115
ADDRLP4 4
ARGP4
ADDRGP4 $64
ARGP4
ADDRLP4 1512
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1512
INDIRP4
ARGP4
ADDRLP4 1516
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1516
INDIRI4
CNSTI4 0
NEI4 $113
LABELV $115
ADDRGP4 $110
JUMPV
LABELV $113
line 147
;146:		//skip spectators
;147:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 4
ARGP4
ADDRGP4 $68
ARGP4
ADDRLP4 1520
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1520
INDIRP4
ARGP4
ADDRLP4 1524
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1524
INDIRI4
CNSTI4 3
NEI4 $116
ADDRGP4 $110
JUMPV
LABELV $116
line 149
;148:		//
;149:		BotAI_GetClientState(i, &ps);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1028
ARGP4
ADDRGP4 BotAI_GetClientState
CALLI4
pop
line 150
;150:		if (ps.persistant[PERS_SCORE] > bestscore) {
ADDRLP4 1028+248
INDIRI4
ADDRLP4 1496
INDIRI4
LEI4 $118
line 151
;151:			bestscore = ps.persistant[PERS_SCORE];
ADDRLP4 1496
ADDRLP4 1028+248
INDIRI4
ASGNI4
line 152
;152:			bestclient = i;
ADDRLP4 1500
ADDRLP4 0
INDIRI4
ASGNI4
line 153
;153:		}
LABELV $118
line 154
;154:	}
LABELV $110
line 142
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $112
ADDRLP4 0
INDIRI4
ADDRGP4 $106
INDIRI4
GEI4 $122
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $109
LABELV $122
line 155
;155:	EasyClientName(bestclient, name, 32);
ADDRLP4 1500
INDIRI4
ARGI4
ADDRGP4 $105
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 156
;156:	return name;
ADDRGP4 $105
RETP4
LABELV $104
endproc BotFirstClientInRankings 1528 12
bss
align 1
LABELV $124
skip 32
align 4
LABELV $125
skip 4
export BotLastClientInRankings
code
proc BotLastClientInRankings 1528 12
line 164
;157:}
;158:
;159:/*
;160:==================
;161:BotLastClientInRankings
;162:==================
;163:*/
;164:char *BotLastClientInRankings(void) {
line 171
;165:	int i, worstscore, bestclient;
;166:	char buf[MAX_INFO_STRING];
;167:	static char name[32];
;168:	static int maxclients;
;169:	playerState_t ps;
;170:
;171:	if (!maxclients)
ADDRGP4 $125
INDIRI4
CNSTI4 0
NEI4 $126
line 172
;172:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $57
ARGP4
ADDRLP4 1504
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $125
ADDRLP4 1504
INDIRI4
ASGNI4
LABELV $126
line 174
;173:
;174:	worstscore = 999999;
ADDRLP4 1496
CNSTI4 999999
ASGNI4
line 175
;175:	bestclient = 0;
ADDRLP4 1500
CNSTI4 0
ASGNI4
line 176
;176:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $131
JUMPV
LABELV $128
line 177
;177:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 179
;178:		//if no config string or no name
;179:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 4
ARGP4
ADDRLP4 1508
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1508
INDIRI4
CNSTI4 0
EQI4 $134
ADDRLP4 4
ARGP4
ADDRGP4 $64
ARGP4
ADDRLP4 1512
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1512
INDIRP4
ARGP4
ADDRLP4 1516
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1516
INDIRI4
CNSTI4 0
NEI4 $132
LABELV $134
ADDRGP4 $129
JUMPV
LABELV $132
line 181
;180:		//skip spectators
;181:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 4
ARGP4
ADDRGP4 $68
ARGP4
ADDRLP4 1520
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1520
INDIRP4
ARGP4
ADDRLP4 1524
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1524
INDIRI4
CNSTI4 3
NEI4 $135
ADDRGP4 $129
JUMPV
LABELV $135
line 183
;182:		//
;183:		BotAI_GetClientState(i, &ps);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1028
ARGP4
ADDRGP4 BotAI_GetClientState
CALLI4
pop
line 184
;184:		if (ps.persistant[PERS_SCORE] < worstscore) {
ADDRLP4 1028+248
INDIRI4
ADDRLP4 1496
INDIRI4
GEI4 $137
line 185
;185:			worstscore = ps.persistant[PERS_SCORE];
ADDRLP4 1496
ADDRLP4 1028+248
INDIRI4
ASGNI4
line 186
;186:			bestclient = i;
ADDRLP4 1500
ADDRLP4 0
INDIRI4
ASGNI4
line 187
;187:		}
LABELV $137
line 188
;188:	}
LABELV $129
line 176
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $131
ADDRLP4 0
INDIRI4
ADDRGP4 $125
INDIRI4
GEI4 $141
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $128
LABELV $141
line 189
;189:	EasyClientName(bestclient, name, 32);
ADDRLP4 1500
INDIRI4
ARGI4
ADDRGP4 $124
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 190
;190:	return name;
ADDRGP4 $124
RETP4
LABELV $123
endproc BotLastClientInRankings 1528 12
bss
align 4
LABELV $143
skip 4
align 1
LABELV $144
skip 32
export BotRandomOpponentName
code
proc BotRandomOpponentName 1320 12
line 198
;191:}
;192:
;193:/*
;194:==================
;195:BotRandomOpponentName
;196:==================
;197:*/
;198:char *BotRandomOpponentName(bot_state_t *bs) {
line 205
;199:	int i, count;
;200:	char buf[MAX_INFO_STRING];
;201:	int opponents[MAX_CLIENTS], numopponents;
;202:	static int maxclients;
;203:	static char name[32];
;204:
;205:	if (!maxclients)
ADDRGP4 $143
INDIRI4
CNSTI4 0
NEI4 $145
line 206
;206:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $57
ARGP4
ADDRLP4 1292
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $143
ADDRLP4 1292
INDIRI4
ASGNI4
LABELV $145
line 208
;207:
;208:	numopponents = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 209
;209:	opponents[0] = 0;
ADDRLP4 1036
CNSTI4 0
ASGNI4
line 210
;210:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $150
JUMPV
LABELV $147
line 211
;211:		if (i == bs->client) continue;
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $151
ADDRGP4 $148
JUMPV
LABELV $151
line 213
;212:		//
;213:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 215
;214:		//if no config string or no name
;215:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 4
ARGP4
ADDRLP4 1296
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1296
INDIRI4
CNSTI4 0
EQI4 $155
ADDRLP4 4
ARGP4
ADDRGP4 $64
ARGP4
ADDRLP4 1300
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1300
INDIRP4
ARGP4
ADDRLP4 1304
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1304
INDIRI4
CNSTI4 0
NEI4 $153
LABELV $155
ADDRGP4 $148
JUMPV
LABELV $153
line 217
;216:		//skip spectators
;217:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 4
ARGP4
ADDRGP4 $68
ARGP4
ADDRLP4 1308
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1308
INDIRP4
ARGP4
ADDRLP4 1312
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1312
INDIRI4
CNSTI4 3
NEI4 $156
ADDRGP4 $148
JUMPV
LABELV $156
line 219
;218:		//skip team mates
;219:		if (BotSameTeam(bs, i)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1316
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1316
INDIRI4
CNSTI4 0
EQI4 $158
ADDRGP4 $148
JUMPV
LABELV $158
line 221
;220:		//
;221:		opponents[numopponents] = i;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1036
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 222
;222:		numopponents++;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 223
;223:	}
LABELV $148
line 210
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $150
ADDRLP4 0
INDIRI4
ADDRGP4 $143
INDIRI4
GEI4 $160
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $147
LABELV $160
line 224
;224:	count = random() * numopponents;
ADDRLP4 1300
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 1300
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 1028
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 225
;225:	for (i = 0; i < numopponents; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $164
JUMPV
LABELV $161
line 226
;226:		count--;
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 227
;227:		if (count <= 0) {
ADDRLP4 1032
INDIRI4
CNSTI4 0
GTI4 $165
line 228
;228:			EasyClientName(opponents[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1036
ADDP4
INDIRI4
ARGI4
ADDRGP4 $144
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 229
;229:			return name;
ADDRGP4 $144
RETP4
ADDRGP4 $142
JUMPV
LABELV $165
line 231
;230:		}
;231:	}
LABELV $162
line 225
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $164
ADDRLP4 0
INDIRI4
ADDRLP4 1028
INDIRI4
LTI4 $161
line 232
;232:	EasyClientName(opponents[0], name, sizeof(name));
ADDRLP4 1036
INDIRI4
ARGI4
ADDRGP4 $144
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 233
;233:	return name;
ADDRGP4 $144
RETP4
LABELV $142
endproc BotRandomOpponentName 1320 12
bss
align 1
LABELV $168
skip 128
export BotMapTitle
code
proc BotMapTitle 1028 12
line 242
;234:}
;235:
;236:/*
;237:==================
;238:BotMapTitle
;239:==================
;240:*/
;241:
;242:char *BotMapTitle(void) {
line 246
;243:	char info[1024];
;244:	static char mapname[128];
;245:
;246:	trap_GetServerinfo(info, sizeof(info));
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetServerinfo
CALLV
pop
line 248
;247:
;248:	strncpy(mapname, Info_ValueForKey( info, "mapname" ), sizeof(mapname)-1);
ADDRLP4 0
ARGP4
ADDRGP4 $169
ARGP4
ADDRLP4 1024
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $168
ARGP4
ADDRLP4 1024
INDIRP4
ARGP4
CNSTI4 127
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 249
;249:	mapname[sizeof(mapname)-1] = '\0';
ADDRGP4 $168+127
CNSTI1 0
ASGNI1
line 251
;250:
;251:	return mapname;
ADDRGP4 $168
RETP4
LABELV $167
endproc BotMapTitle 1028 12
export BotWeaponNameForMeansOfDeath
proc BotWeaponNameForMeansOfDeath 4 0
line 261
;252:}
;253:
;254:
;255:/*
;256:==================
;257:BotWeaponNameForMeansOfDeath
;258:==================
;259:*/
;260:
;261:char *BotWeaponNameForMeansOfDeath(int mod) {
line 262
;262:	switch(mod) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $172
ADDRLP4 0
INDIRI4
CNSTI4 23
GTI4 $172
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $195-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $195
address $174
address $176
address $178
address $180
address $180
address $182
address $182
address $184
address $184
address $186
address $188
address $190
address $190
address $172
address $172
address $172
address $172
address $172
address $172
address $172
address $172
address $172
address $192
code
LABELV $174
line 263
;263:		case MOD_SHOTGUN: return "Shotgun";
ADDRGP4 $175
RETP4
ADDRGP4 $171
JUMPV
LABELV $176
line 264
;264:		case MOD_GAUNTLET: return "Gauntlet";
ADDRGP4 $177
RETP4
ADDRGP4 $171
JUMPV
LABELV $178
line 265
;265:		case MOD_MACHINEGUN: return "Machinegun";
ADDRGP4 $179
RETP4
ADDRGP4 $171
JUMPV
LABELV $180
line 267
;266:		case MOD_GRENADE:
;267:		case MOD_GRENADE_SPLASH: return "Grenade Launcher";
ADDRGP4 $181
RETP4
ADDRGP4 $171
JUMPV
LABELV $182
line 269
;268:		case MOD_ROCKET:
;269:		case MOD_ROCKET_SPLASH: return "Rocket Launcher";
ADDRGP4 $183
RETP4
ADDRGP4 $171
JUMPV
LABELV $184
line 271
;270:		case MOD_PLASMA:
;271:		case MOD_PLASMA_SPLASH: return "Plasmagun";
ADDRGP4 $185
RETP4
ADDRGP4 $171
JUMPV
LABELV $186
line 272
;272:		case MOD_RAILGUN: return "Railgun";
ADDRGP4 $187
RETP4
ADDRGP4 $171
JUMPV
LABELV $188
line 273
;273:		case MOD_LIGHTNING: return "Lightning Gun";
ADDRGP4 $189
RETP4
ADDRGP4 $171
JUMPV
LABELV $190
line 275
;274:		case MOD_BFG:
;275:		case MOD_BFG_SPLASH: return "BFG10K";
ADDRGP4 $191
RETP4
ADDRGP4 $171
JUMPV
LABELV $192
line 283
;276:#ifdef MISSIONPACK
;277:		case MOD_NAIL: return "Nailgun";
;278:		case MOD_CHAINGUN: return "Chaingun";
;279:		case MOD_PROXIMITY_MINE: return "Proximity Launcher";
;280:		case MOD_KAMIKAZE: return "Kamikaze";
;281:		case MOD_JUICED: return "Prox mine";
;282:#endif
;283:		case MOD_GRAPPLE: return "Grapple";
ADDRGP4 $193
RETP4
ADDRGP4 $171
JUMPV
LABELV $172
line 284
;284:		default: return "[unknown weapon]";
ADDRGP4 $194
RETP4
LABELV $171
endproc BotWeaponNameForMeansOfDeath 4 0
export BotRandomWeaponName
proc BotRandomWeaponName 12 0
line 293
;285:	}
;286:}
;287:
;288:/*
;289:==================
;290:BotRandomWeaponName
;291:==================
;292:*/
;293:char *BotRandomWeaponName(void) {
line 299
;294:	int rnd;
;295:
;296:#ifdef MISSIONPACK
;297:	rnd = random() * 11.9;
;298:#else
;299:	rnd = random() * 8.9;
ADDRLP4 4
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
CNSTF4 1091462758
ADDRLP4 4
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
CVFI4 4
ASGNI4
line 301
;300:#endif
;301:	switch(rnd) {
ADDRLP4 8
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $198
ADDRLP4 8
INDIRI4
CNSTI4 7
GTI4 $198
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $208
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $208
address $200
address $201
address $202
address $203
address $204
address $205
address $206
address $207
code
LABELV $200
line 302
;302:		case 0: return "Gauntlet";
ADDRGP4 $177
RETP4
ADDRGP4 $197
JUMPV
LABELV $201
line 303
;303:		case 1: return "Shotgun";
ADDRGP4 $175
RETP4
ADDRGP4 $197
JUMPV
LABELV $202
line 304
;304:		case 2: return "Machinegun";
ADDRGP4 $179
RETP4
ADDRGP4 $197
JUMPV
LABELV $203
line 305
;305:		case 3: return "Grenade Launcher";
ADDRGP4 $181
RETP4
ADDRGP4 $197
JUMPV
LABELV $204
line 306
;306:		case 4: return "Rocket Launcher";
ADDRGP4 $183
RETP4
ADDRGP4 $197
JUMPV
LABELV $205
line 307
;307:		case 5: return "Plasmagun";
ADDRGP4 $185
RETP4
ADDRGP4 $197
JUMPV
LABELV $206
line 308
;308:		case 6: return "Railgun";
ADDRGP4 $187
RETP4
ADDRGP4 $197
JUMPV
LABELV $207
line 309
;309:		case 7: return "Lightning Gun";
ADDRGP4 $189
RETP4
ADDRGP4 $197
JUMPV
LABELV $198
line 315
;310:#ifdef MISSIONPACK
;311:		case 8: return "Nailgun";
;312:		case 9: return "Chaingun";
;313:		case 10: return "Proximity Launcher";
;314:#endif
;315:		default: return "BFG10K";
ADDRGP4 $191
RETP4
LABELV $197
endproc BotRandomWeaponName 12 0
export BotVisibleEnemies
proc BotVisibleEnemies 172 20
line 324
;316:	}
;317:}
;318:
;319:/*
;320:==================
;321:BotVisibleEnemies
;322:==================
;323:*/
;324:int BotVisibleEnemies(bot_state_t *bs) {
line 329
;325:	float vis;
;326:	int i;
;327:	aas_entityinfo_t entinfo;
;328:
;329:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $210
line 331
;330:
;331:		if (i == bs->client) continue;
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $214
ADDRGP4 $211
JUMPV
LABELV $214
line 333
;332:		//
;333:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 335
;334:		//
;335:		if (!entinfo.valid) continue;
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $216
ADDRGP4 $211
JUMPV
LABELV $216
line 337
;336:		//if the enemy isn't dead and the enemy isn't the bot self
;337:		if (EntityIsDead(&entinfo) || entinfo.number == bs->entitynum) continue;
ADDRLP4 4
ARGP4
ADDRLP4 148
ADDRGP4 EntityIsDead
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $221
ADDRLP4 4+20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $218
LABELV $221
ADDRGP4 $211
JUMPV
LABELV $218
line 339
;338:		//if the enemy is invisible and not shooting
;339:		if (EntityIsInvisible(&entinfo) && !EntityIsShooting(&entinfo)) {
ADDRLP4 4
ARGP4
ADDRLP4 152
ADDRGP4 EntityIsInvisible
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $222
ADDRLP4 4
ARGP4
ADDRLP4 156
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
NEI4 $222
line 340
;340:			continue;
ADDRGP4 $211
JUMPV
LABELV $222
line 343
;341:		}
;342:		//if on the same team
;343:		if (BotSameTeam(bs, i)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 160
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
EQI4 $224
ADDRGP4 $211
JUMPV
LABELV $224
line 345
;344:		//check if the enemy is visible
;345:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
ADDRLP4 164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 164
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 164
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 164
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 168
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 144
ADDRLP4 168
INDIRF4
ASGNF4
line 346
;346:		if (vis > 0) return qtrue;
ADDRLP4 144
INDIRF4
CNSTF4 0
LEF4 $226
CNSTI4 1
RETI4
ADDRGP4 $209
JUMPV
LABELV $226
line 347
;347:	}
LABELV $211
line 329
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $210
line 348
;348:	return qfalse;
CNSTI4 0
RETI4
LABELV $209
endproc BotVisibleEnemies 172 20
export BotValidChatPosition
proc BotValidChatPosition 164 28
line 356
;349:}
;350:
;351:/*
;352:==================
;353:BotValidChatPosition
;354:==================
;355:*/
;356:int BotValidChatPosition(bot_state_t *bs) {
line 361
;357:	vec3_t point, start, end, mins, maxs;
;358:	bsp_trace_t trace;
;359:
;360:	//if the bot is dead all positions are valid
;361:	if (BotIsDead(bs)) return qtrue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 BotIsDead
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $229
CNSTI4 1
RETI4
ADDRGP4 $228
JUMPV
LABELV $229
line 363
;362:	//never start chatting with a powerup
;363:	if (bs->inventory[INVENTORY_QUAD] ||
ADDRLP4 148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 152
CNSTI4 0
ASGNI4
ADDRLP4 148
INDIRP4
CNSTI4 5092
ADDP4
INDIRI4
ADDRLP4 152
INDIRI4
NEI4 $236
ADDRLP4 148
INDIRP4
CNSTI4 5100
ADDP4
INDIRI4
ADDRLP4 152
INDIRI4
NEI4 $236
ADDRLP4 148
INDIRP4
CNSTI4 5104
ADDP4
INDIRI4
ADDRLP4 152
INDIRI4
NEI4 $236
ADDRLP4 148
INDIRP4
CNSTI4 5108
ADDP4
INDIRI4
ADDRLP4 152
INDIRI4
NEI4 $236
ADDRLP4 148
INDIRP4
CNSTI4 5112
ADDP4
INDIRI4
ADDRLP4 152
INDIRI4
EQI4 $231
LABELV $236
line 367
;364:		bs->inventory[INVENTORY_HASTE] ||
;365:		bs->inventory[INVENTORY_INVISIBILITY] ||
;366:		bs->inventory[INVENTORY_REGEN] ||
;367:		bs->inventory[INVENTORY_FLIGHT]) return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $228
JUMPV
LABELV $231
line 371
;368:	//must be on the ground
;369:	//if (bs->cur_ps.groundEntityNum != ENTITYNUM_NONE) return qfalse;
;370:	//do not chat if in lava or slime
;371:	VectorCopy(bs->origin, point);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 372
;372:	point[2] -= 24;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 373
;373:	if (trap_PointContents(point,bs->entitynum) & (CONTENTS_LAVA|CONTENTS_SLIME)) return qfalse;
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 156
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
EQI4 $238
CNSTI4 0
RETI4
ADDRGP4 $228
JUMPV
LABELV $238
line 375
;374:	//do not chat if under water
;375:	VectorCopy(bs->origin, point);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 376
;376:	point[2] += 32;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 377
;377:	if (trap_PointContents(point,bs->entitynum) & MASK_WATER) return qfalse;
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 160
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $241
CNSTI4 0
RETI4
ADDRGP4 $228
JUMPV
LABELV $241
line 379
;378:	//must be standing on the world entity
;379:	VectorCopy(bs->origin, start);
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 380
;380:	VectorCopy(bs->origin, end);
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 381
;381:	start[2] += 1;
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 382
;382:	end[2] -= 10;
ADDRLP4 24+8
ADDRLP4 24+8
INDIRF4
CNSTF4 1092616192
SUBF4
ASGNF4
line 383
;383:	trap_AAS_PresenceTypeBoundingBox(PRESENCE_CROUCH, mins, maxs);
CNSTI4 4
ARGI4
ADDRLP4 36
ARGP4
ADDRLP4 48
ARGP4
ADDRGP4 trap_AAS_PresenceTypeBoundingBox
CALLV
pop
line 384
;384:	BotAI_Trace(&trace, start, mins, maxs, end, bs->client, MASK_SOLID);
ADDRLP4 60
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 48
ARGP4
ADDRLP4 24
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 385
;385:	if (trace.ent != ENTITYNUM_WORLD) return qfalse;
ADDRLP4 60+80
INDIRI4
CNSTI4 1022
EQI4 $245
CNSTI4 0
RETI4
ADDRGP4 $228
JUMPV
LABELV $245
line 387
;386:	//the bot is in a position where it can chat
;387:	return qtrue;
CNSTI4 1
RETI4
LABELV $228
endproc BotValidChatPosition 164 28
export BotChat_EnterGame
proc BotChat_EnterGame 68 32
line 395
;388:}
;389:
;390:/*
;391:==================
;392:BotChat_EnterGame
;393:==================
;394:*/
;395:int BotChat_EnterGame(bot_state_t *bs) {
line 399
;396:	char name[32];
;397:	float rnd;
;398:
;399:	if (bot_nochat.integer) return qfalse;
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
EQI4 $249
CNSTI4 0
RETI4
ADDRGP4 $248
JUMPV
LABELV $249
line 400
;400:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $252
CNSTI4 0
RETI4
ADDRGP4 $248
JUMPV
LABELV $252
line 402
;401:	//don't chat in teamplay
;402:	if (TeamPlayIsOn()) return qfalse;
ADDRLP4 36
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $254
CNSTI4 0
RETI4
ADDRGP4 $248
JUMPV
LABELV $254
line 404
;403:	// don't chat in tournament mode
;404:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $256
CNSTI4 0
RETI4
ADDRGP4 $248
JUMPV
LABELV $256
line 405
;405:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_ENTEREXITGAME, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 27
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 40
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 40
INDIRF4
ASGNF4
line 406
;406:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $258
line 407
;407:		if (random() > rnd) return qfalse;
ADDRLP4 44
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 0
INDIRF4
LEF4 $261
CNSTI4 0
RETI4
ADDRGP4 $248
JUMPV
LABELV $261
line 408
;408:	}
LABELV $258
line 409
;409:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 44
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 1
GTI4 $263
CNSTI4 0
RETI4
ADDRGP4 $248
JUMPV
LABELV $263
line 410
;410:	if (!BotValidChatPosition(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $265
CNSTI4 0
RETI4
ADDRGP4 $248
JUMPV
LABELV $265
line 411
;411:	BotAI_BotInitialChat(bs, "game_enter",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 52
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 60
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $267
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 $268
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 418
;412:				EasyClientName(bs->client, name, 32),	// 0
;413:				BotRandomOpponentName(bs),				// 1
;414:				"[invalid var]",						// 2
;415:				"[invalid var]",						// 3
;416:				BotMapTitle(),							// 4
;417:				NULL);
;418:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 419
;419:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 0
ASGNI4
line 420
;420:	return qtrue;
CNSTI4 1
RETI4
LABELV $248
endproc BotChat_EnterGame 68 32
export BotChat_ExitGame
proc BotChat_ExitGame 64 32
line 428
;421:}
;422:
;423:/*
;424:==================
;425:BotChat_ExitGame
;426:==================
;427:*/
;428:int BotChat_ExitGame(bot_state_t *bs) {
line 432
;429:	char name[32];
;430:	float rnd;
;431:
;432:	if (bot_nochat.integer) return qfalse;
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
EQI4 $270
CNSTI4 0
RETI4
ADDRGP4 $269
JUMPV
LABELV $270
line 433
;433:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $273
CNSTI4 0
RETI4
ADDRGP4 $269
JUMPV
LABELV $273
line 435
;434:	//don't chat in teamplay
;435:	if (TeamPlayIsOn()) return qfalse;
ADDRLP4 36
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $275
CNSTI4 0
RETI4
ADDRGP4 $269
JUMPV
LABELV $275
line 437
;436:	// don't chat in tournament mode
;437:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $277
CNSTI4 0
RETI4
ADDRGP4 $269
JUMPV
LABELV $277
line 438
;438:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_ENTEREXITGAME, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 27
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 40
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 40
INDIRF4
ASGNF4
line 439
;439:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $279
line 440
;440:		if (random() > rnd) return qfalse;
ADDRLP4 44
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 0
INDIRF4
LEF4 $282
CNSTI4 0
RETI4
ADDRGP4 $269
JUMPV
LABELV $282
line 441
;441:	}
LABELV $279
line 442
;442:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 44
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 1
GTI4 $284
CNSTI4 0
RETI4
ADDRGP4 $269
JUMPV
LABELV $284
line 444
;443:	//
;444:	BotAI_BotInitialChat(bs, "game_exit",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 48
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 56
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $286
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 $268
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 451
;445:				EasyClientName(bs->client, name, 32),	// 0
;446:				BotRandomOpponentName(bs),				// 1
;447:				"[invalid var]",						// 2
;448:				"[invalid var]",						// 3
;449:				BotMapTitle(),							// 4
;450:				NULL);
;451:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 452
;452:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 0
ASGNI4
line 453
;453:	return qtrue;
CNSTI4 1
RETI4
LABELV $269
endproc BotChat_ExitGame 64 32
export BotChat_StartLevel
proc BotChat_StartLevel 56 16
line 461
;454:}
;455:
;456:/*
;457:==================
;458:BotChat_StartLevel
;459:==================
;460:*/
;461:int BotChat_StartLevel(bot_state_t *bs) {
line 465
;462:	char name[32];
;463:	float rnd;
;464:
;465:	if (bot_nochat.integer) return qfalse;
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
EQI4 $288
CNSTI4 0
RETI4
ADDRGP4 $287
JUMPV
LABELV $288
line 466
;466:	if (BotIsObserver(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $291
CNSTI4 0
RETI4
ADDRGP4 $287
JUMPV
LABELV $291
line 467
;467:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $293
CNSTI4 0
RETI4
ADDRGP4 $287
JUMPV
LABELV $293
line 469
;468:	//don't chat in teamplay
;469:	if (TeamPlayIsOn()) {
ADDRLP4 40
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $295
line 470
;470:	    trap_EA_Command(bs->client, "vtaunt");
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $297
ARGP4
ADDRGP4 trap_EA_Command
CALLV
pop
line 471
;471:	    return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $287
JUMPV
LABELV $295
line 474
;472:	}
;473:	// don't chat in tournament mode
;474:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $298
CNSTI4 0
RETI4
ADDRGP4 $287
JUMPV
LABELV $298
line 475
;475:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_STARTENDLEVEL, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 26
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 44
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 44
INDIRF4
ASGNF4
line 476
;476:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $300
line 477
;477:		if (random() > rnd) return qfalse;
ADDRLP4 48
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 0
INDIRF4
LEF4 $303
CNSTI4 0
RETI4
ADDRGP4 $287
JUMPV
LABELV $303
line 478
;478:	}
LABELV $300
line 479
;479:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 48
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 1
GTI4 $305
CNSTI4 0
RETI4
ADDRGP4 $287
JUMPV
LABELV $305
line 480
;480:	BotAI_BotInitialChat(bs, "level_start",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 52
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $307
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 483
;481:				EasyClientName(bs->client, name, 32),	// 0
;482:				NULL);
;483:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 484
;484:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 0
ASGNI4
line 485
;485:	return qtrue;
CNSTI4 1
RETI4
LABELV $287
endproc BotChat_StartLevel 56 16
export BotChat_EndLevel
proc BotChat_EndLevel 80 32
line 493
;486:}
;487:
;488:/*
;489:==================
;490:BotChat_EndLevel
;491:==================
;492:*/
;493:int BotChat_EndLevel(bot_state_t *bs) {
line 497
;494:	char name[32];
;495:	float rnd;
;496:
;497:	if (bot_nochat.integer) return qfalse;
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
EQI4 $309
CNSTI4 0
RETI4
ADDRGP4 $308
JUMPV
LABELV $309
line 498
;498:	if (BotIsObserver(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $312
CNSTI4 0
RETI4
ADDRGP4 $308
JUMPV
LABELV $312
line 499
;499:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $314
CNSTI4 0
RETI4
ADDRGP4 $308
JUMPV
LABELV $314
line 501
;500:	// teamplay
;501:	if (TeamPlayIsOn()) 
ADDRLP4 40
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $316
line 502
;502:	{
line 503
;503:		if (BotIsFirstInRankings(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 BotIsFirstInRankings
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $318
line 504
;504:			trap_EA_Command(bs->client, "vtaunt");
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $297
ARGP4
ADDRGP4 trap_EA_Command
CALLV
pop
line 505
;505:		}
LABELV $318
line 506
;506:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $308
JUMPV
LABELV $316
line 509
;507:	}
;508:	// don't chat in tournament mode
;509:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $320
CNSTI4 0
RETI4
ADDRGP4 $308
JUMPV
LABELV $320
line 510
;510:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_STARTENDLEVEL, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 26
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 44
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 44
INDIRF4
ASGNF4
line 511
;511:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $322
line 512
;512:		if (random() > rnd) return qfalse;
ADDRLP4 48
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 0
INDIRF4
LEF4 $325
CNSTI4 0
RETI4
ADDRGP4 $308
JUMPV
LABELV $325
line 513
;513:	}
LABELV $322
line 514
;514:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 48
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 1
GTI4 $327
CNSTI4 0
RETI4
ADDRGP4 $308
JUMPV
LABELV $327
line 516
;515:	//
;516:	if (BotIsFirstInRankings(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 BotIsFirstInRankings
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $329
line 517
;517:		BotAI_BotInitialChat(bs, "level_end_victory",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 56
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 64
ADDRGP4 BotLastClientInRankings
CALLP4
ASGNP4
ADDRLP4 68
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $331
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRGP4 $268
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 524
;518:				EasyClientName(bs->client, name, 32),	// 0
;519:				BotRandomOpponentName(bs),				// 1
;520:				"[invalid var]",						// 2
;521:				BotLastClientInRankings(),				// 3
;522:				BotMapTitle(),							// 4
;523:				NULL);
;524:	}
ADDRGP4 $330
JUMPV
LABELV $329
line 525
;525:	else if (BotIsLastInRankings(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 BotIsLastInRankings
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $332
line 526
;526:		BotAI_BotInitialChat(bs, "level_end_lose",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 60
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 68
ADDRGP4 BotFirstClientInRankings
CALLP4
ASGNP4
ADDRLP4 72
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $334
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRGP4 $268
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 533
;527:				EasyClientName(bs->client, name, 32),	// 0
;528:				BotRandomOpponentName(bs),				// 1
;529:				BotFirstClientInRankings(),				// 2
;530:				"[invalid var]",						// 3
;531:				BotMapTitle(),							// 4
;532:				NULL);
;533:	}
ADDRGP4 $333
JUMPV
LABELV $332
line 534
;534:	else {
line 535
;535:		BotAI_BotInitialChat(bs, "level_end",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 60
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 68
ADDRGP4 BotFirstClientInRankings
CALLP4
ASGNP4
ADDRLP4 72
ADDRGP4 BotLastClientInRankings
CALLP4
ASGNP4
ADDRLP4 76
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $335
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 542
;536:				EasyClientName(bs->client, name, 32),	// 0
;537:				BotRandomOpponentName(bs),				// 1
;538:				BotFirstClientInRankings(),				// 2
;539:				BotLastClientInRankings(),				// 3
;540:				BotMapTitle(),							// 4
;541:				NULL);
;542:	}
LABELV $333
LABELV $330
line 543
;543:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 544
;544:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 0
ASGNI4
line 545
;545:	return qtrue;
CNSTI4 1
RETI4
LABELV $308
endproc BotChat_EndLevel 80 32
export BotChat_Death
proc BotChat_Death 116 20
line 553
;546:}
;547:
;548:/*
;549:==================
;550:BotChat_Death
;551:==================
;552:*/
;553:int BotChat_Death(bot_state_t *bs) {
line 557
;554:	char name[32];
;555:	float rnd;
;556:
;557:	if (bot_nochat.integer) return qfalse;
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
EQI4 $337
CNSTI4 0
RETI4
ADDRGP4 $336
JUMPV
LABELV $337
line 558
;558:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $340
CNSTI4 0
RETI4
ADDRGP4 $336
JUMPV
LABELV $340
line 559
;559:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_DEATH, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 29
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 36
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 32
ADDRLP4 36
INDIRF4
ASGNF4
line 561
;560:	// don't chat in tournament mode
;561:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $342
CNSTI4 0
RETI4
ADDRGP4 $336
JUMPV
LABELV $342
line 563
;562:	//if fast chatting is off
;563:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $344
line 564
;564:		if (random() > rnd) return qfalse;
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 32
INDIRF4
LEF4 $347
CNSTI4 0
RETI4
ADDRGP4 $336
JUMPV
LABELV $347
line 565
;565:	}
LABELV $344
line 566
;566:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 40
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 1
GTI4 $349
CNSTI4 0
RETI4
ADDRGP4 $336
JUMPV
LABELV $349
line 568
;567:	//
;568:	if (bs->lastkilledby >= 0 && bs->lastkilledby < MAX_CLIENTS)
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 5996
ADDP4
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
LTI4 $351
ADDRLP4 44
INDIRI4
CNSTI4 64
GEI4 $351
line 569
;569:		EasyClientName(bs->lastkilledby, name, 32);
ADDRFP4 0
INDIRP4
CNSTI4 5996
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
ADDRGP4 $352
JUMPV
LABELV $351
line 571
;570:	else
;571:		strcpy(name, "[world]");
ADDRLP4 0
ARGP4
ADDRGP4 $353
ARGP4
ADDRGP4 strcpy
CALLP4
pop
LABELV $352
line 573
;572:	//
;573:	if (TeamPlayIsOn() && BotSameTeam(bs, bs->lastkilledby)) {
ADDRLP4 48
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $354
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
CNSTI4 5996
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $354
line 574
;574:		if (bs->lastkilledby == bs->client) return qfalse;
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 5996
ADDP4
INDIRI4
ADDRLP4 60
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $356
CNSTI4 0
RETI4
ADDRGP4 $336
JUMPV
LABELV $356
line 575
;575:		BotAI_BotInitialChat(bs, "death_teammate", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $358
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 576
;576:		bs->chatto = CHAT_TEAM;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 1
ASGNI4
line 577
;577:	}
ADDRGP4 $355
JUMPV
LABELV $354
line 579
;578:	else
;579:	{
line 581
;580:		//teamplay
;581:		if (TeamPlayIsOn()) {
ADDRLP4 60
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $359
line 582
;582:			trap_EA_Command(bs->client, "vtaunt");
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $297
ARGP4
ADDRGP4 trap_EA_Command
CALLV
pop
line 583
;583:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $336
JUMPV
LABELV $359
line 586
;584:		}
;585:		//
;586:		if (bs->botdeathtype == MOD_WATER)
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
CNSTI4 14
NEI4 $361
line 587
;587:			BotAI_BotInitialChat(bs, "death_drown", BotRandomOpponentName(bs), NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $363
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $362
JUMPV
LABELV $361
line 588
;588:		else if (bs->botdeathtype == MOD_SLIME)
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
CNSTI4 15
NEI4 $364
line 589
;589:			BotAI_BotInitialChat(bs, "death_slime", BotRandomOpponentName(bs), NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $366
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $365
JUMPV
LABELV $364
line 590
;590:		else if (bs->botdeathtype == MOD_LAVA)
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
CNSTI4 16
NEI4 $367
line 591
;591:			BotAI_BotInitialChat(bs, "death_lava", BotRandomOpponentName(bs), NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $369
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $368
JUMPV
LABELV $367
line 592
;592:		else if (bs->botdeathtype == MOD_FALLING)
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
CNSTI4 19
NEI4 $370
line 593
;593:			BotAI_BotInitialChat(bs, "death_cratered", BotRandomOpponentName(bs), NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $372
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $371
JUMPV
LABELV $370
line 594
;594:		else if (bs->botsuicide || //all other suicides by own weapon
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
CNSTI4 0
ASGNI4
ADDRLP4 80
INDIRP4
CNSTI4 6008
ADDP4
INDIRI4
ADDRLP4 84
INDIRI4
NEI4 $379
ADDRLP4 88
ADDRLP4 80
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 17
EQI4 $379
ADDRLP4 88
INDIRI4
CNSTI4 20
EQI4 $379
ADDRLP4 88
INDIRI4
CNSTI4 21
EQI4 $379
ADDRLP4 88
INDIRI4
CNSTI4 22
EQI4 $379
ADDRLP4 88
INDIRI4
ADDRLP4 84
INDIRI4
NEI4 $373
LABELV $379
line 600
;595:				bs->botdeathtype == MOD_CRUSH ||
;596:				bs->botdeathtype == MOD_SUICIDE ||
;597:				bs->botdeathtype == MOD_TARGET_LASER ||
;598:				bs->botdeathtype == MOD_TRIGGER_HURT ||
;599:				bs->botdeathtype == MOD_UNKNOWN)
;600:			BotAI_BotInitialChat(bs, "death_suicide", BotRandomOpponentName(bs), NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $380
ARGP4
ADDRLP4 92
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $374
JUMPV
LABELV $373
line 601
;601:		else if (bs->botdeathtype == MOD_TELEFRAG)
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
CNSTI4 18
NEI4 $381
line 602
;602:			BotAI_BotInitialChat(bs, "death_telefrag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $383
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $382
JUMPV
LABELV $381
line 607
;603:#ifdef MISSIONPACK
;604:		else if (bs->botdeathtype == MOD_KAMIKAZE && trap_BotNumInitialChats(bs->cs, "death_kamikaze"))
;605:			BotAI_BotInitialChat(bs, "death_kamikaze", name, NULL);
;606:#endif
;607:		else {
line 608
;608:			if ((bs->botdeathtype == MOD_GAUNTLET ||
ADDRLP4 96
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 2
EQI4 $388
ADDRLP4 96
INDIRI4
CNSTI4 10
EQI4 $388
ADDRLP4 96
INDIRI4
CNSTI4 12
EQI4 $388
ADDRLP4 96
INDIRI4
CNSTI4 13
NEI4 $384
LABELV $388
ADDRLP4 100
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
GEF4 $384
line 611
;609:				bs->botdeathtype == MOD_RAILGUN ||
;610:				bs->botdeathtype == MOD_BFG ||
;611:				bs->botdeathtype == MOD_BFG_SPLASH) && random() < 0.5) {
line 613
;612:
;613:				if (bs->botdeathtype == MOD_GAUNTLET)
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
CNSTI4 2
NEI4 $389
line 614
;614:					BotAI_BotInitialChat(bs, "death_gauntlet",
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
ARGI4
ADDRLP4 104
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $391
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 104
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $385
JUMPV
LABELV $389
line 618
;615:							name,												// 0
;616:							BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;617:							NULL);
;618:				else if (bs->botdeathtype == MOD_RAILGUN)
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
CNSTI4 10
NEI4 $392
line 619
;619:					BotAI_BotInitialChat(bs, "death_rail",
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
ARGI4
ADDRLP4 108
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $394
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 108
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $385
JUMPV
LABELV $392
line 624
;620:							name,												// 0
;621:							BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;622:							NULL);
;623:				else
;624:					BotAI_BotInitialChat(bs, "death_bfg",
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
ARGI4
ADDRLP4 112
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $395
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 112
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 628
;625:							name,												// 0
;626:							BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;627:							NULL);
;628:			}
ADDRGP4 $385
JUMPV
LABELV $384
line 630
;629:			//choose between insult and praise
;630:			else if (random() < trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_INSULT, 0, 1)) {
ADDRLP4 104
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 24
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 108
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 104
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 108
INDIRF4
GEF4 $396
line 631
;631:				BotAI_BotInitialChat(bs, "death_insult",
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
ARGI4
ADDRLP4 112
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $398
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 112
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 635
;632:							name,												// 0
;633:							BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;634:							NULL);
;635:			}
ADDRGP4 $397
JUMPV
LABELV $396
line 636
;636:			else {
line 637
;637:				BotAI_BotInitialChat(bs, "death_praise",
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
ARGI4
ADDRLP4 112
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $399
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 112
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 641
;638:							name,												// 0
;639:							BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;640:							NULL);
;641:			}
LABELV $397
LABELV $385
line 642
;642:		}
LABELV $382
LABELV $374
LABELV $371
LABELV $368
LABELV $365
LABELV $362
line 643
;643:		bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 0
ASGNI4
line 644
;644:	}
LABELV $355
line 645
;645:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 646
;646:	return qtrue;
CNSTI4 1
RETI4
LABELV $336
endproc BotChat_Death 116 20
export BotChat_Kill
proc BotChat_Kill 80 16
line 654
;647:}
;648:
;649:/*
;650:==================
;651:BotChat_Kill
;652:==================
;653:*/
;654:int BotChat_Kill(bot_state_t *bs) {
line 658
;655:	char name[32];
;656:	float rnd;
;657:
;658:	if (bot_nochat.integer) return qfalse;
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
EQI4 $401
CNSTI4 0
RETI4
ADDRGP4 $400
JUMPV
LABELV $401
line 659
;659:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $404
CNSTI4 0
RETI4
ADDRGP4 $400
JUMPV
LABELV $404
line 660
;660:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_KILL, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 28
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 36
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 32
ADDRLP4 36
INDIRF4
ASGNF4
line 662
;661:	// don't chat in tournament mode
;662:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $406
CNSTI4 0
RETI4
ADDRGP4 $400
JUMPV
LABELV $406
line 664
;663:	//if fast chat is off
;664:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $408
line 665
;665:		if (random() > rnd) return qfalse;
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 32
INDIRF4
LEF4 $411
CNSTI4 0
RETI4
ADDRGP4 $400
JUMPV
LABELV $411
line 666
;666:	}
LABELV $408
line 667
;667:	if (bs->lastkilledplayer == bs->client) return qfalse;
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
ADDRLP4 40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $413
CNSTI4 0
RETI4
ADDRGP4 $400
JUMPV
LABELV $413
line 668
;668:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 44
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 1
GTI4 $415
CNSTI4 0
RETI4
ADDRGP4 $400
JUMPV
LABELV $415
line 669
;669:	if (!BotValidChatPosition(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $417
CNSTI4 0
RETI4
ADDRGP4 $400
JUMPV
LABELV $417
line 671
;670:	//
;671:	if (BotVisibleEnemies(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 BotVisibleEnemies
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $419
CNSTI4 0
RETI4
ADDRGP4 $400
JUMPV
LABELV $419
line 673
;672:	//
;673:	EasyClientName(bs->lastkilledplayer, name, 32);
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 675
;674:	//
;675:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 0
ASGNI4
line 676
;676:	if (TeamPlayIsOn() && BotSameTeam(bs, bs->lastkilledplayer)) {
ADDRLP4 56
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $421
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $421
line 677
;677:		BotAI_BotInitialChat(bs, "kill_teammate", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $423
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 678
;678:		bs->chatto = CHAT_TEAM;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 1
ASGNI4
line 679
;679:	}
ADDRGP4 $422
JUMPV
LABELV $421
line 681
;680:	else
;681:	{
line 683
;682:		//don't chat in teamplay
;683:		if (TeamPlayIsOn()) {
ADDRLP4 68
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $424
line 684
;684:			trap_EA_Command(bs->client, "vtaunt");
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $297
ARGP4
ADDRGP4 trap_EA_Command
CALLV
pop
line 685
;685:			return qfalse;			// don't wait
CNSTI4 0
RETI4
ADDRGP4 $400
JUMPV
LABELV $424
line 688
;686:		}
;687:		//
;688:		if (bs->enemydeathtype == MOD_GAUNTLET) {
ADDRFP4 0
INDIRP4
CNSTI4 6004
ADDP4
INDIRI4
CNSTI4 2
NEI4 $426
line 689
;689:			BotAI_BotInitialChat(bs, "kill_gauntlet", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $428
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 690
;690:		}
ADDRGP4 $427
JUMPV
LABELV $426
line 691
;691:		else if (bs->enemydeathtype == MOD_RAILGUN) {
ADDRFP4 0
INDIRP4
CNSTI4 6004
ADDP4
INDIRI4
CNSTI4 10
NEI4 $429
line 692
;692:			BotAI_BotInitialChat(bs, "kill_rail", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $431
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 693
;693:		}
ADDRGP4 $430
JUMPV
LABELV $429
line 694
;694:		else if (bs->enemydeathtype == MOD_TELEFRAG) {
ADDRFP4 0
INDIRP4
CNSTI4 6004
ADDP4
INDIRI4
CNSTI4 18
NEI4 $432
line 695
;695:			BotAI_BotInitialChat(bs, "kill_telefrag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $434
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 696
;696:		}
ADDRGP4 $433
JUMPV
LABELV $432
line 702
;697:#ifdef MISSIONPACK
;698:		else if (bs->botdeathtype == MOD_KAMIKAZE && trap_BotNumInitialChats(bs->cs, "kill_kamikaze"))
;699:			BotAI_BotInitialChat(bs, "kill_kamikaze", name, NULL);
;700:#endif
;701:		//choose between insult and praise
;702:		else if (random() < trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_INSULT, 0, 1)) {
ADDRLP4 72
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 24
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 76
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 72
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 76
INDIRF4
GEF4 $435
line 703
;703:			BotAI_BotInitialChat(bs, "kill_insult", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $437
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 704
;704:		}
ADDRGP4 $436
JUMPV
LABELV $435
line 705
;705:		else {
line 706
;706:			BotAI_BotInitialChat(bs, "kill_praise", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $438
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 707
;707:		}
LABELV $436
LABELV $433
LABELV $430
LABELV $427
line 708
;708:	}
LABELV $422
line 709
;709:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 710
;710:	return qtrue;
CNSTI4 1
RETI4
LABELV $400
endproc BotChat_Kill 80 16
export BotChat_EnemySuicide
proc BotChat_EnemySuicide 56 16
line 718
;711:}
;712:
;713:/*
;714:==================
;715:BotChat_EnemySuicide
;716:==================
;717:*/
;718:int BotChat_EnemySuicide(bot_state_t *bs) {
line 722
;719:	char name[32];
;720:	float rnd;
;721:
;722:	if (bot_nochat.integer) return qfalse;
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
EQI4 $440
CNSTI4 0
RETI4
ADDRGP4 $439
JUMPV
LABELV $440
line 723
;723:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $443
CNSTI4 0
RETI4
ADDRGP4 $439
JUMPV
LABELV $443
line 724
;724:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 36
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 1
GTI4 $445
CNSTI4 0
RETI4
ADDRGP4 $439
JUMPV
LABELV $445
line 726
;725:	//
;726:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_KILL, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 28
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 40
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 32
ADDRLP4 40
INDIRF4
ASGNF4
line 728
;727:	//don't chat in teamplay
;728:	if (TeamPlayIsOn()) return qfalse;
ADDRLP4 44
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $447
CNSTI4 0
RETI4
ADDRGP4 $439
JUMPV
LABELV $447
line 730
;729:	// don't chat in tournament mode
;730:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $449
CNSTI4 0
RETI4
ADDRGP4 $439
JUMPV
LABELV $449
line 732
;731:	//if fast chat is off
;732:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $451
line 733
;733:		if (random() > rnd) return qfalse;
ADDRLP4 48
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 32
INDIRF4
LEF4 $454
CNSTI4 0
RETI4
ADDRGP4 $439
JUMPV
LABELV $454
line 734
;734:	}
LABELV $451
line 735
;735:	if (!BotValidChatPosition(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $456
CNSTI4 0
RETI4
ADDRGP4 $439
JUMPV
LABELV $456
line 737
;736:	//
;737:	if (BotVisibleEnemies(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 BotVisibleEnemies
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $458
CNSTI4 0
RETI4
ADDRGP4 $439
JUMPV
LABELV $458
line 739
;738:	//
;739:	if (bs->enemy >= 0) EasyClientName(bs->enemy, name, 32);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
CNSTI4 0
LTI4 $460
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
ADDRGP4 $461
JUMPV
LABELV $460
line 740
;740:	else strcpy(name, "");
ADDRLP4 0
ARGP4
ADDRGP4 $462
ARGP4
ADDRGP4 strcpy
CALLP4
pop
LABELV $461
line 741
;741:	BotAI_BotInitialChat(bs, "enemy_suicide", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $463
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 742
;742:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 743
;743:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 0
ASGNI4
line 744
;744:	return qtrue;
CNSTI4 1
RETI4
LABELV $439
endproc BotChat_EnemySuicide 56 16
export BotChat_HitTalking
proc BotChat_HitTalking 68 20
line 752
;745:}
;746:
;747:/*
;748:==================
;749:BotChat_HitTalking
;750:==================
;751:*/
;752:int BotChat_HitTalking(bot_state_t *bs) {
line 757
;753:	char name[32], *weap;
;754:	int lasthurt_client;
;755:	float rnd;
;756:
;757:	if (bot_nochat.integer) return qfalse;
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
EQI4 $465
CNSTI4 0
RETI4
ADDRGP4 $464
JUMPV
LABELV $465
line 758
;758:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $468
CNSTI4 0
RETI4
ADDRGP4 $464
JUMPV
LABELV $468
line 759
;759:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 44
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 1
GTI4 $470
CNSTI4 0
RETI4
ADDRGP4 $464
JUMPV
LABELV $470
line 760
;760:	lasthurt_client = g_entities[bs->client].client->lasthurt_client;
ADDRLP4 0
CNSTI4 808
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 724
ADDP4
INDIRI4
ASGNI4
line 761
;761:	if (!lasthurt_client) return qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $473
CNSTI4 0
RETI4
ADDRGP4 $464
JUMPV
LABELV $473
line 762
;762:	if (lasthurt_client == bs->client) return qfalse;
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $475
CNSTI4 0
RETI4
ADDRGP4 $464
JUMPV
LABELV $475
line 764
;763:	//
;764:	if (lasthurt_client < 0 || lasthurt_client >= MAX_CLIENTS) return qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $479
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $477
LABELV $479
CNSTI4 0
RETI4
ADDRGP4 $464
JUMPV
LABELV $477
line 766
;765:	//
;766:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_HITTALKING, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 31
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 52
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 52
INDIRF4
ASGNF4
line 768
;767:	//don't chat in teamplay
;768:	if (TeamPlayIsOn()) return qfalse;
ADDRLP4 56
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $480
CNSTI4 0
RETI4
ADDRGP4 $464
JUMPV
LABELV $480
line 770
;769:	// don't chat in tournament mode
;770:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $482
CNSTI4 0
RETI4
ADDRGP4 $464
JUMPV
LABELV $482
line 772
;771:	//if fast chat is off
;772:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $484
line 773
;773:		if (random() > rnd * 0.5) return qfalse;
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
ADDRLP4 40
INDIRF4
MULF4
LEF4 $487
CNSTI4 0
RETI4
ADDRGP4 $464
JUMPV
LABELV $487
line 774
;774:	}
LABELV $484
line 775
;775:	if (!BotValidChatPosition(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $489
CNSTI4 0
RETI4
ADDRGP4 $464
JUMPV
LABELV $489
line 777
;776:	//
;777:	ClientName(g_entities[bs->client].client->lasthurt_client, name, sizeof(name));
CNSTI4 808
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 724
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 778
;778:	weap = BotWeaponNameForMeansOfDeath(g_entities[bs->client].client->lasthurt_client);
CNSTI4 808
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 724
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRLP4 36
ADDRLP4 64
INDIRP4
ASGNP4
line 780
;779:	//
;780:	BotAI_BotInitialChat(bs, "hit_talking", name, weap, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $493
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 781
;781:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 782
;782:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 0
ASGNI4
line 783
;783:	return qtrue;
CNSTI4 1
RETI4
LABELV $464
endproc BotChat_HitTalking 68 20
export BotChat_HitNoDeath
proc BotChat_HitNoDeath 216 20
line 791
;784:}
;785:
;786:/*
;787:==================
;788:BotChat_HitNoDeath
;789:==================
;790:*/
;791:int BotChat_HitNoDeath(bot_state_t *bs) {
line 797
;792:	char name[32], *weap;
;793:	float rnd;
;794:	int lasthurt_client;
;795:	aas_entityinfo_t entinfo;
;796:
;797:	lasthurt_client = g_entities[bs->client].client->lasthurt_client;
ADDRLP4 0
CNSTI4 808
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 724
ADDP4
INDIRI4
ASGNI4
line 798
;798:	if (!lasthurt_client) return qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $496
CNSTI4 0
RETI4
ADDRGP4 $494
JUMPV
LABELV $496
line 799
;799:	if (lasthurt_client == bs->client) return qfalse;
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $498
CNSTI4 0
RETI4
ADDRGP4 $494
JUMPV
LABELV $498
line 801
;800:	//
;801:	if (lasthurt_client < 0 || lasthurt_client >= MAX_CLIENTS) return qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $502
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $500
LABELV $502
CNSTI4 0
RETI4
ADDRGP4 $494
JUMPV
LABELV $500
line 803
;802:	//
;803:	if (bot_nochat.integer) return qfalse;
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
EQI4 $503
CNSTI4 0
RETI4
ADDRGP4 $494
JUMPV
LABELV $503
line 804
;804:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $506
CNSTI4 0
RETI4
ADDRGP4 $494
JUMPV
LABELV $506
line 805
;805:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 188
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 1
GTI4 $508
CNSTI4 0
RETI4
ADDRGP4 $494
JUMPV
LABELV $508
line 806
;806:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_HITNODEATH, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 32
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 192
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 180
ADDRLP4 192
INDIRF4
ASGNF4
line 808
;807:	//don't chat in teamplay
;808:	if (TeamPlayIsOn()) return qfalse;
ADDRLP4 196
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
EQI4 $510
CNSTI4 0
RETI4
ADDRGP4 $494
JUMPV
LABELV $510
line 810
;809:	// don't chat in tournament mode
;810:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $512
CNSTI4 0
RETI4
ADDRGP4 $494
JUMPV
LABELV $512
line 812
;811:	//if fast chat is off
;812:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $514
line 813
;813:		if (random() > rnd * 0.5) return qfalse;
ADDRLP4 200
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
ADDRLP4 180
INDIRF4
MULF4
LEF4 $517
CNSTI4 0
RETI4
ADDRGP4 $494
JUMPV
LABELV $517
line 814
;814:	}
LABELV $514
line 815
;815:	if (!BotValidChatPosition(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 200
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 0
NEI4 $519
CNSTI4 0
RETI4
ADDRGP4 $494
JUMPV
LABELV $519
line 817
;816:	//
;817:	if (BotVisibleEnemies(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 204
ADDRGP4 BotVisibleEnemies
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 0
EQI4 $521
CNSTI4 0
RETI4
ADDRGP4 $494
JUMPV
LABELV $521
line 819
;818:	//
;819:	BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 820
;820:	if (EntityIsShooting(&entinfo)) return qfalse;
ADDRLP4 40
ARGP4
ADDRLP4 208
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 208
INDIRI4
CNSTI4 0
EQI4 $523
CNSTI4 0
RETI4
ADDRGP4 $494
JUMPV
LABELV $523
line 822
;821:	//
;822:	ClientName(lasthurt_client, name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 823
;823:	weap = BotWeaponNameForMeansOfDeath(g_entities[bs->client].client->lasthurt_mod);
CNSTI4 808
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 728
ADDP4
INDIRI4
ARGI4
ADDRLP4 212
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRLP4 36
ADDRLP4 212
INDIRP4
ASGNP4
line 825
;824:	//
;825:	BotAI_BotInitialChat(bs, "hit_nodeath", name, weap, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $526
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 826
;826:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 827
;827:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 0
ASGNI4
line 828
;828:	return qtrue;
CNSTI4 1
RETI4
LABELV $494
endproc BotChat_HitNoDeath 216 20
export BotChat_HitNoKill
proc BotChat_HitNoKill 208 20
line 836
;829:}
;830:
;831:/*
;832:==================
;833:BotChat_HitNoKill
;834:==================
;835:*/
;836:int BotChat_HitNoKill(bot_state_t *bs) {
line 841
;837:	char name[32], *weap;
;838:	float rnd;
;839:	aas_entityinfo_t entinfo;
;840:
;841:	if (bot_nochat.integer) return qfalse;
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
EQI4 $528
CNSTI4 0
RETI4
ADDRGP4 $527
JUMPV
LABELV $528
line 842
;842:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $531
CNSTI4 0
RETI4
ADDRGP4 $527
JUMPV
LABELV $531
line 843
;843:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 180
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 1
GTI4 $533
CNSTI4 0
RETI4
ADDRGP4 $527
JUMPV
LABELV $533
line 844
;844:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_HITNOKILL, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 33
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 184
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 176
ADDRLP4 184
INDIRF4
ASGNF4
line 846
;845:	//don't chat in teamplay
;846:	if (TeamPlayIsOn()) return qfalse;
ADDRLP4 188
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 0
EQI4 $535
CNSTI4 0
RETI4
ADDRGP4 $527
JUMPV
LABELV $535
line 848
;847:	// don't chat in tournament mode
;848:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $537
CNSTI4 0
RETI4
ADDRGP4 $527
JUMPV
LABELV $537
line 850
;849:	//if fast chat is off
;850:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $539
line 851
;851:		if (random() > rnd * 0.5) return qfalse;
ADDRLP4 192
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
ADDRLP4 176
INDIRF4
MULF4
LEF4 $542
CNSTI4 0
RETI4
ADDRGP4 $527
JUMPV
LABELV $542
line 852
;852:	}
LABELV $539
line 853
;853:	if (!BotValidChatPosition(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 192
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
NEI4 $544
CNSTI4 0
RETI4
ADDRGP4 $527
JUMPV
LABELV $544
line 855
;854:	//
;855:	if (BotVisibleEnemies(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 BotVisibleEnemies
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
EQI4 $546
CNSTI4 0
RETI4
ADDRGP4 $527
JUMPV
LABELV $546
line 857
;856:	//
;857:	BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 858
;858:	if (EntityIsShooting(&entinfo)) return qfalse;
ADDRLP4 36
ARGP4
ADDRLP4 200
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 0
EQI4 $548
CNSTI4 0
RETI4
ADDRGP4 $527
JUMPV
LABELV $548
line 860
;859:	//
;860:	ClientName(bs->enemy, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 861
;861:	weap = BotWeaponNameForMeansOfDeath(g_entities[bs->enemy].client->lasthurt_mod);
CNSTI4 808
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 728
ADDP4
INDIRI4
ARGI4
ADDRLP4 204
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRLP4 32
ADDRLP4 204
INDIRP4
ASGNP4
line 863
;862:	//
;863:	BotAI_BotInitialChat(bs, "hit_nokill", name, weap, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $551
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 864
;864:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 865
;865:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 0
ASGNI4
line 866
;866:	return qtrue;
CNSTI4 1
RETI4
LABELV $527
endproc BotChat_HitNoKill 208 20
export BotChat_Random
proc BotChat_Random 96 36
line 874
;867:}
;868:
;869:/*
;870:==================
;871:BotChat_Random
;872:==================
;873:*/
;874:int BotChat_Random(bot_state_t *bs) {
line 878
;875:	float rnd;
;876:	char name[32];
;877:
;878:	if (bot_nochat.integer) return qfalse;
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
EQI4 $553
CNSTI4 0
RETI4
ADDRGP4 $552
JUMPV
LABELV $553
line 879
;879:	if (BotIsObserver(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $556
CNSTI4 0
RETI4
ADDRGP4 $552
JUMPV
LABELV $556
line 880
;880:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $558
CNSTI4 0
RETI4
ADDRGP4 $552
JUMPV
LABELV $558
line 882
;881:	// don't chat in tournament mode
;882:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $560
CNSTI4 0
RETI4
ADDRGP4 $552
JUMPV
LABELV $560
line 884
;883:	//don't chat when doing something important :)
;884:	if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 1
EQI4 $565
ADDRLP4 40
INDIRI4
CNSTI4 2
EQI4 $565
ADDRLP4 40
INDIRI4
CNSTI4 5
NEI4 $562
LABELV $565
line 886
;885:		bs->ltgtype == LTG_TEAMACCOMPANY ||
;886:		bs->ltgtype == LTG_RUSHBASE) return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $552
JUMPV
LABELV $562
line 888
;887:	//
;888:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_RANDOM, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 34
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 44
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 32
ADDRLP4 44
INDIRF4
ASGNF4
line 889
;889:	if (random() > bs->thinktime * 0.1) return qfalse;
ADDRLP4 48
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1036831949
ADDRFP4 0
INDIRP4
CNSTI4 4904
ADDP4
INDIRF4
MULF4
LEF4 $566
CNSTI4 0
RETI4
ADDRGP4 $552
JUMPV
LABELV $566
line 890
;890:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $568
line 891
;891:		if (random() > rnd) return qfalse;
ADDRLP4 52
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 32
INDIRF4
LEF4 $571
CNSTI4 0
RETI4
ADDRGP4 $552
JUMPV
LABELV $571
line 892
;892:		if (random() > 0.25) return qfalse;
ADDRLP4 56
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1048576000
LEF4 $573
CNSTI4 0
RETI4
ADDRGP4 $552
JUMPV
LABELV $573
line 893
;893:	}
LABELV $568
line 894
;894:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 52
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 1
GTI4 $575
CNSTI4 0
RETI4
ADDRGP4 $552
JUMPV
LABELV $575
line 896
;895:	//
;896:	if (!BotValidChatPosition(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $577
CNSTI4 0
RETI4
ADDRGP4 $552
JUMPV
LABELV $577
line 898
;897:	//
;898:	if (BotVisibleEnemies(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 BotVisibleEnemies
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $579
CNSTI4 0
RETI4
ADDRGP4 $552
JUMPV
LABELV $579
line 900
;899:	//
;900:	if (bs->lastkilledplayer == bs->client) {
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
ADDRLP4 64
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $581
line 901
;901:		strcpy(name, BotRandomOpponentName(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 902
;902:	}
ADDRGP4 $582
JUMPV
LABELV $581
line 903
;903:	else {
line 904
;904:		EasyClientName(bs->lastkilledplayer, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 905
;905:	}
LABELV $582
line 906
;906:	if (TeamPlayIsOn()) {
ADDRLP4 68
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $583
line 907
;907:		trap_EA_Command(bs->client, "vtaunt");
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $297
ARGP4
ADDRGP4 trap_EA_Command
CALLV
pop
line 908
;908:		return qfalse;			// don't wait
CNSTI4 0
RETI4
ADDRGP4 $552
JUMPV
LABELV $583
line 911
;909:	}
;910:	//
;911:	if (random() < trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_MISC, 0, 1)) {
ADDRLP4 72
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 25
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 76
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 72
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 76
INDIRF4
GEF4 $585
line 912
;912:		BotAI_BotInitialChat(bs, "random_misc",
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 84
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRLP4 88
ADDRGP4 BotRandomWeaponName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $587
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 92
ADDRGP4 $268
ASGNP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 920
;913:					BotRandomOpponentName(bs),	// 0
;914:					name,						// 1
;915:					"[invalid var]",			// 2
;916:					"[invalid var]",			// 3
;917:					BotMapTitle(),				// 4
;918:					BotRandomWeaponName(),		// 5
;919:					NULL);
;920:	}
ADDRGP4 $586
JUMPV
LABELV $585
line 921
;921:	else {
line 922
;922:		BotAI_BotInitialChat(bs, "random_insult",
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 84
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRLP4 88
ADDRGP4 BotRandomWeaponName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $588
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 92
ADDRGP4 $268
ASGNP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 930
;923:					BotRandomOpponentName(bs),	// 0
;924:					name,						// 1
;925:					"[invalid var]",			// 2
;926:					"[invalid var]",			// 3
;927:					BotMapTitle(),				// 4
;928:					BotRandomWeaponName(),		// 5
;929:					NULL);
;930:	}
LABELV $586
line 931
;931:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 932
;932:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 0
ASGNI4
line 933
;933:	return qtrue;
CNSTI4 1
RETI4
LABELV $552
endproc BotChat_Random 96 36
export BotChatTime
proc BotChatTime 8 16
line 941
;934:}
;935:
;936:/*
;937:==================
;938:BotChatTime
;939:==================
;940:*/
;941:float BotChatTime(bot_state_t *bs) {
line 944
;942:	int cpm;
;943:
;944:	cpm = trap_Characteristic_BInteger(bs->character, CHARACTERISTIC_CHAT_CPM, 1, 4000);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 23
ARGI4
CNSTI4 1
ARGI4
CNSTI4 4000
ARGI4
ADDRLP4 4
ADDRGP4 trap_Characteristic_BInteger
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 946
;945:
;946:	return 2.0;	//(float) trap_BotChatLength(bs->cs) * 30 / cpm;
CNSTF4 1073741824
RETF4
LABELV $589
endproc BotChatTime 8 16
export BotChatTest
proc BotChatTest 184 36
line 954
;947:}
;948:
;949:/*
;950:==================
;951:BotChatTest
;952:==================
;953:*/
;954:void BotChatTest(bot_state_t *bs) {
line 960
;955:
;956:	char name[32];
;957:	char *weap;
;958:	int num, i;
;959:
;960:	num = trap_BotNumInitialChats(bs->cs, "game_enter");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $267
ARGP4
ADDRLP4 44
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 44
INDIRI4
ASGNI4
line 961
;961:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $594
JUMPV
LABELV $591
line 962
;962:	{
line 963
;963:		BotAI_BotInitialChat(bs, "game_enter",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 48
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 56
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $267
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 $268
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 970
;964:					EasyClientName(bs->client, name, 32),	// 0
;965:					BotRandomOpponentName(bs),				// 1
;966:					"[invalid var]",						// 2
;967:					"[invalid var]",						// 3
;968:					BotMapTitle(),							// 4
;969:					NULL);
;970:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 971
;971:	}
LABELV $592
line 961
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $594
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $591
line 972
;972:	num = trap_BotNumInitialChats(bs->cs, "game_exit");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $286
ARGP4
ADDRLP4 48
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 48
INDIRI4
ASGNI4
line 973
;973:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $598
JUMPV
LABELV $595
line 974
;974:	{
line 975
;975:		BotAI_BotInitialChat(bs, "game_exit",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 52
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 60
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $286
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 $268
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 982
;976:					EasyClientName(bs->client, name, 32),	// 0
;977:					BotRandomOpponentName(bs),				// 1
;978:					"[invalid var]",						// 2
;979:					"[invalid var]",						// 3
;980:					BotMapTitle(),							// 4
;981:					NULL);
;982:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRLP4 68
INDIRI4
ARGI4
ADDRLP4 68
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 983
;983:	}
LABELV $596
line 973
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $598
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $595
line 984
;984:	num = trap_BotNumInitialChats(bs->cs, "level_start");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $307
ARGP4
ADDRLP4 52
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 52
INDIRI4
ASGNI4
line 985
;985:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $602
JUMPV
LABELV $599
line 986
;986:	{
line 987
;987:		BotAI_BotInitialChat(bs, "level_start",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 56
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $307
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 990
;988:					EasyClientName(bs->client, name, 32),	// 0
;989:					NULL);
;990:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 991
;991:	}
LABELV $600
line 985
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $602
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $599
line 992
;992:	num = trap_BotNumInitialChats(bs->cs, "level_end_victory");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $331
ARGP4
ADDRLP4 56
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 56
INDIRI4
ASGNI4
line 993
;993:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $606
JUMPV
LABELV $603
line 994
;994:	{
line 995
;995:		BotAI_BotInitialChat(bs, "level_end_victory",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 60
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 68
ADDRGP4 BotFirstClientInRankings
CALLP4
ASGNP4
ADDRLP4 72
ADDRGP4 BotLastClientInRankings
CALLP4
ASGNP4
ADDRLP4 76
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $331
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1002
;996:				EasyClientName(bs->client, name, 32),	// 0
;997:				BotRandomOpponentName(bs),				// 1
;998:				BotFirstClientInRankings(),				// 2
;999:				BotLastClientInRankings(),				// 3
;1000:				BotMapTitle(),							// 4
;1001:				NULL);
;1002:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 80
CNSTI4 0
ASGNI4
ADDRLP4 80
INDIRI4
ARGI4
ADDRLP4 80
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1003
;1003:	}
LABELV $604
line 993
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $606
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $603
line 1004
;1004:	num = trap_BotNumInitialChats(bs->cs, "level_end_lose");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $334
ARGP4
ADDRLP4 60
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 60
INDIRI4
ASGNI4
line 1005
;1005:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $610
JUMPV
LABELV $607
line 1006
;1006:	{
line 1007
;1007:		BotAI_BotInitialChat(bs, "level_end_lose",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 64
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 72
ADDRGP4 BotFirstClientInRankings
CALLP4
ASGNP4
ADDRLP4 76
ADDRGP4 BotLastClientInRankings
CALLP4
ASGNP4
ADDRLP4 80
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $334
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1014
;1008:				EasyClientName(bs->client, name, 32),	// 0
;1009:				BotRandomOpponentName(bs),				// 1
;1010:				BotFirstClientInRankings(),				// 2
;1011:				BotLastClientInRankings(),				// 3
;1012:				BotMapTitle(),							// 4
;1013:				NULL);
;1014:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 84
CNSTI4 0
ASGNI4
ADDRLP4 84
INDIRI4
ARGI4
ADDRLP4 84
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1015
;1015:	}
LABELV $608
line 1005
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $610
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $607
line 1016
;1016:	num = trap_BotNumInitialChats(bs->cs, "level_end");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $335
ARGP4
ADDRLP4 64
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 64
INDIRI4
ASGNI4
line 1017
;1017:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $614
JUMPV
LABELV $611
line 1018
;1018:	{
line 1019
;1019:		BotAI_BotInitialChat(bs, "level_end",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 68
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 76
ADDRGP4 BotFirstClientInRankings
CALLP4
ASGNP4
ADDRLP4 80
ADDRGP4 BotLastClientInRankings
CALLP4
ASGNP4
ADDRLP4 84
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $335
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1026
;1020:				EasyClientName(bs->client, name, 32),	// 0
;1021:				BotRandomOpponentName(bs),				// 1
;1022:				BotFirstClientInRankings(),				// 2
;1023:				BotLastClientInRankings(),				// 3
;1024:				BotMapTitle(),							// 4
;1025:				NULL);
;1026:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 88
CNSTI4 0
ASGNI4
ADDRLP4 88
INDIRI4
ARGI4
ADDRLP4 88
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1027
;1027:	}
LABELV $612
line 1017
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $614
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $611
line 1028
;1028:	EasyClientName(bs->lastkilledby, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 5996
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 1029
;1029:	num = trap_BotNumInitialChats(bs->cs, "death_drown");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $363
ARGP4
ADDRLP4 68
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 68
INDIRI4
ASGNI4
line 1030
;1030:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $618
JUMPV
LABELV $615
line 1031
;1031:	{
line 1033
;1032:		//
;1033:		BotAI_BotInitialChat(bs, "death_drown", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $363
ARGP4
ADDRLP4 8
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1034
;1034:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
CNSTI4 0
ASGNI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1035
;1035:	}
LABELV $616
line 1030
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $618
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $615
line 1036
;1036:	num = trap_BotNumInitialChats(bs->cs, "death_slime");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $366
ARGP4
ADDRLP4 72
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 72
INDIRI4
ASGNI4
line 1037
;1037:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $622
JUMPV
LABELV $619
line 1038
;1038:	{
line 1039
;1039:		BotAI_BotInitialChat(bs, "death_slime", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $366
ARGP4
ADDRLP4 8
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1040
;1040:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1041
;1041:	}
LABELV $620
line 1037
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $622
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $619
line 1042
;1042:	num = trap_BotNumInitialChats(bs->cs, "death_lava");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $369
ARGP4
ADDRLP4 76
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 76
INDIRI4
ASGNI4
line 1043
;1043:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $626
JUMPV
LABELV $623
line 1044
;1044:	{
line 1045
;1045:		BotAI_BotInitialChat(bs, "death_lava", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $369
ARGP4
ADDRLP4 8
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1046
;1046:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 80
CNSTI4 0
ASGNI4
ADDRLP4 80
INDIRI4
ARGI4
ADDRLP4 80
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1047
;1047:	}
LABELV $624
line 1043
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $626
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $623
line 1048
;1048:	num = trap_BotNumInitialChats(bs->cs, "death_cratered");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $372
ARGP4
ADDRLP4 80
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 80
INDIRI4
ASGNI4
line 1049
;1049:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $630
JUMPV
LABELV $627
line 1050
;1050:	{
line 1051
;1051:		BotAI_BotInitialChat(bs, "death_cratered", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $372
ARGP4
ADDRLP4 8
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1052
;1052:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 84
CNSTI4 0
ASGNI4
ADDRLP4 84
INDIRI4
ARGI4
ADDRLP4 84
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1053
;1053:	}
LABELV $628
line 1049
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $630
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $627
line 1054
;1054:	num = trap_BotNumInitialChats(bs->cs, "death_suicide");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $380
ARGP4
ADDRLP4 84
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 84
INDIRI4
ASGNI4
line 1055
;1055:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $634
JUMPV
LABELV $631
line 1056
;1056:	{
line 1057
;1057:		BotAI_BotInitialChat(bs, "death_suicide", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $380
ARGP4
ADDRLP4 8
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1058
;1058:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 88
CNSTI4 0
ASGNI4
ADDRLP4 88
INDIRI4
ARGI4
ADDRLP4 88
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1059
;1059:	}
LABELV $632
line 1055
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $634
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $631
line 1060
;1060:	num = trap_BotNumInitialChats(bs->cs, "death_telefrag");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $383
ARGP4
ADDRLP4 88
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 88
INDIRI4
ASGNI4
line 1061
;1061:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $638
JUMPV
LABELV $635
line 1062
;1062:	{
line 1063
;1063:		BotAI_BotInitialChat(bs, "death_telefrag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $383
ARGP4
ADDRLP4 8
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1064
;1064:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 92
CNSTI4 0
ASGNI4
ADDRLP4 92
INDIRI4
ARGI4
ADDRLP4 92
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1065
;1065:	}
LABELV $636
line 1061
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $638
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $635
line 1066
;1066:	num = trap_BotNumInitialChats(bs->cs, "death_gauntlet");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $391
ARGP4
ADDRLP4 92
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 92
INDIRI4
ASGNI4
line 1067
;1067:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $642
JUMPV
LABELV $639
line 1068
;1068:	{
line 1069
;1069:		BotAI_BotInitialChat(bs, "death_gauntlet",
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
ARGI4
ADDRLP4 96
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $391
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1073
;1070:				name,												// 0
;1071:				BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;1072:				NULL);
;1073:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 100
CNSTI4 0
ASGNI4
ADDRLP4 100
INDIRI4
ARGI4
ADDRLP4 100
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1074
;1074:	}
LABELV $640
line 1067
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $642
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $639
line 1075
;1075:	num = trap_BotNumInitialChats(bs->cs, "death_rail");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $394
ARGP4
ADDRLP4 96
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 96
INDIRI4
ASGNI4
line 1076
;1076:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $646
JUMPV
LABELV $643
line 1077
;1077:	{
line 1078
;1078:		BotAI_BotInitialChat(bs, "death_rail",
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
ARGI4
ADDRLP4 100
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $394
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1082
;1079:				name,												// 0
;1080:				BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;1081:				NULL);
;1082:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 104
CNSTI4 0
ASGNI4
ADDRLP4 104
INDIRI4
ARGI4
ADDRLP4 104
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1083
;1083:	}
LABELV $644
line 1076
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $646
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $643
line 1084
;1084:	num = trap_BotNumInitialChats(bs->cs, "death_bfg");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $395
ARGP4
ADDRLP4 100
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 100
INDIRI4
ASGNI4
line 1085
;1085:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $650
JUMPV
LABELV $647
line 1086
;1086:	{
line 1087
;1087:		BotAI_BotInitialChat(bs, "death_bfg",
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
ARGI4
ADDRLP4 104
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $395
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 104
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1091
;1088:				name,												// 0
;1089:				BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;1090:				NULL);
;1091:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 108
CNSTI4 0
ASGNI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1092
;1092:	}
LABELV $648
line 1085
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $650
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $647
line 1093
;1093:	num = trap_BotNumInitialChats(bs->cs, "death_insult");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $398
ARGP4
ADDRLP4 104
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 104
INDIRI4
ASGNI4
line 1094
;1094:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $654
JUMPV
LABELV $651
line 1095
;1095:	{
line 1096
;1096:		BotAI_BotInitialChat(bs, "death_insult",
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
ARGI4
ADDRLP4 108
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $398
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 108
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1100
;1097:					name,												// 0
;1098:					BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;1099:					NULL);
;1100:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 112
CNSTI4 0
ASGNI4
ADDRLP4 112
INDIRI4
ARGI4
ADDRLP4 112
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1101
;1101:	}
LABELV $652
line 1094
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $654
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $651
line 1102
;1102:	num = trap_BotNumInitialChats(bs->cs, "death_praise");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $399
ARGP4
ADDRLP4 108
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 108
INDIRI4
ASGNI4
line 1103
;1103:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $658
JUMPV
LABELV $655
line 1104
;1104:	{
line 1105
;1105:		BotAI_BotInitialChat(bs, "death_praise",
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
ARGI4
ADDRLP4 112
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $399
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 112
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1109
;1106:					name,												// 0
;1107:					BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;1108:					NULL);
;1109:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 116
CNSTI4 0
ASGNI4
ADDRLP4 116
INDIRI4
ARGI4
ADDRLP4 116
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1110
;1110:	}
LABELV $656
line 1103
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $658
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $655
line 1112
;1111:	//
;1112:	EasyClientName(bs->lastkilledplayer, name, 32);
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 1114
;1113:	//
;1114:	num = trap_BotNumInitialChats(bs->cs, "kill_gauntlet");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $428
ARGP4
ADDRLP4 112
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 112
INDIRI4
ASGNI4
line 1115
;1115:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $662
JUMPV
LABELV $659
line 1116
;1116:	{
line 1118
;1117:		//
;1118:		BotAI_BotInitialChat(bs, "kill_gauntlet", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $428
ARGP4
ADDRLP4 8
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1119
;1119:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 116
CNSTI4 0
ASGNI4
ADDRLP4 116
INDIRI4
ARGI4
ADDRLP4 116
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1120
;1120:	}
LABELV $660
line 1115
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $662
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $659
line 1121
;1121:	num = trap_BotNumInitialChats(bs->cs, "kill_rail");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $431
ARGP4
ADDRLP4 116
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 116
INDIRI4
ASGNI4
line 1122
;1122:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $666
JUMPV
LABELV $663
line 1123
;1123:	{
line 1124
;1124:		BotAI_BotInitialChat(bs, "kill_rail", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $431
ARGP4
ADDRLP4 8
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1125
;1125:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 120
CNSTI4 0
ASGNI4
ADDRLP4 120
INDIRI4
ARGI4
ADDRLP4 120
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1126
;1126:	}
LABELV $664
line 1122
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $666
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $663
line 1127
;1127:	num = trap_BotNumInitialChats(bs->cs, "kill_telefrag");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $434
ARGP4
ADDRLP4 120
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 120
INDIRI4
ASGNI4
line 1128
;1128:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $670
JUMPV
LABELV $667
line 1129
;1129:	{
line 1130
;1130:		BotAI_BotInitialChat(bs, "kill_telefrag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $434
ARGP4
ADDRLP4 8
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1131
;1131:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 124
CNSTI4 0
ASGNI4
ADDRLP4 124
INDIRI4
ARGI4
ADDRLP4 124
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1132
;1132:	}
LABELV $668
line 1128
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $670
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $667
line 1133
;1133:	num = trap_BotNumInitialChats(bs->cs, "kill_insult");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $437
ARGP4
ADDRLP4 124
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 124
INDIRI4
ASGNI4
line 1134
;1134:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $674
JUMPV
LABELV $671
line 1135
;1135:	{
line 1136
;1136:		BotAI_BotInitialChat(bs, "kill_insult", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $437
ARGP4
ADDRLP4 8
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1137
;1137:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 128
CNSTI4 0
ASGNI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1138
;1138:	}
LABELV $672
line 1134
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $674
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $671
line 1139
;1139:	num = trap_BotNumInitialChats(bs->cs, "kill_praise");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $438
ARGP4
ADDRLP4 128
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 128
INDIRI4
ASGNI4
line 1140
;1140:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $678
JUMPV
LABELV $675
line 1141
;1141:	{
line 1142
;1142:		BotAI_BotInitialChat(bs, "kill_praise", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $438
ARGP4
ADDRLP4 8
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1143
;1143:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRLP4 132
INDIRI4
ARGI4
ADDRLP4 132
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1144
;1144:	}
LABELV $676
line 1140
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $678
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $675
line 1145
;1145:	num = trap_BotNumInitialChats(bs->cs, "enemy_suicide");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $463
ARGP4
ADDRLP4 132
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 132
INDIRI4
ASGNI4
line 1146
;1146:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $682
JUMPV
LABELV $679
line 1147
;1147:	{
line 1148
;1148:		BotAI_BotInitialChat(bs, "enemy_suicide", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $463
ARGP4
ADDRLP4 8
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1149
;1149:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 136
CNSTI4 0
ASGNI4
ADDRLP4 136
INDIRI4
ARGI4
ADDRLP4 136
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1150
;1150:	}
LABELV $680
line 1146
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $682
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $679
line 1151
;1151:	ClientName(g_entities[bs->client].client->lasthurt_client, name, sizeof(name));
CNSTI4 808
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 724
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1152
;1152:	weap = BotWeaponNameForMeansOfDeath(g_entities[bs->client].client->lasthurt_client);
CNSTI4 808
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 724
ADDP4
INDIRI4
ARGI4
ADDRLP4 136
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRLP4 40
ADDRLP4 136
INDIRP4
ASGNP4
line 1153
;1153:	num = trap_BotNumInitialChats(bs->cs, "hit_talking");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $493
ARGP4
ADDRLP4 140
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 140
INDIRI4
ASGNI4
line 1154
;1154:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $688
JUMPV
LABELV $685
line 1155
;1155:	{
line 1156
;1156:		BotAI_BotInitialChat(bs, "hit_talking", name, weap, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $493
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1157
;1157:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 144
CNSTI4 0
ASGNI4
ADDRLP4 144
INDIRI4
ARGI4
ADDRLP4 144
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1158
;1158:	}
LABELV $686
line 1154
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $688
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $685
line 1159
;1159:	num = trap_BotNumInitialChats(bs->cs, "hit_nodeath");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $526
ARGP4
ADDRLP4 144
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 144
INDIRI4
ASGNI4
line 1160
;1160:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $692
JUMPV
LABELV $689
line 1161
;1161:	{
line 1162
;1162:		BotAI_BotInitialChat(bs, "hit_nodeath", name, weap, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $526
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1163
;1163:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 148
CNSTI4 0
ASGNI4
ADDRLP4 148
INDIRI4
ARGI4
ADDRLP4 148
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1164
;1164:	}
LABELV $690
line 1160
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $692
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $689
line 1165
;1165:	num = trap_BotNumInitialChats(bs->cs, "hit_nokill");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $551
ARGP4
ADDRLP4 148
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 148
INDIRI4
ASGNI4
line 1166
;1166:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $696
JUMPV
LABELV $693
line 1167
;1167:	{
line 1168
;1168:		BotAI_BotInitialChat(bs, "hit_nokill", name, weap, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $551
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1169
;1169:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 152
CNSTI4 0
ASGNI4
ADDRLP4 152
INDIRI4
ARGI4
ADDRLP4 152
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1170
;1170:	}
LABELV $694
line 1166
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $696
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $693
line 1172
;1171:	//
;1172:	if (bs->lastkilledplayer == bs->client) {
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 152
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
ADDRLP4 152
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $697
line 1173
;1173:		strcpy(name, BotRandomOpponentName(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 156
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 8
ARGP4
ADDRLP4 156
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1174
;1174:	}
ADDRGP4 $698
JUMPV
LABELV $697
line 1175
;1175:	else {
line 1176
;1176:		EasyClientName(bs->lastkilledplayer, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 1177
;1177:	}
LABELV $698
line 1179
;1178:	//
;1179:	num = trap_BotNumInitialChats(bs->cs, "random_misc");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $587
ARGP4
ADDRLP4 156
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 156
INDIRI4
ASGNI4
line 1180
;1180:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $702
JUMPV
LABELV $699
line 1181
;1181:	{
line 1183
;1182:		//
;1183:		BotAI_BotInitialChat(bs, "random_misc",
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 160
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 164
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRLP4 168
ADDRGP4 BotRandomWeaponName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $587
ARGP4
ADDRLP4 160
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 172
ADDRGP4 $268
ASGNP4
ADDRLP4 172
INDIRP4
ARGP4
ADDRLP4 172
INDIRP4
ARGP4
ADDRLP4 164
INDIRP4
ARGP4
ADDRLP4 168
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1191
;1184:					BotRandomOpponentName(bs),	// 0
;1185:					name,						// 1
;1186:					"[invalid var]",			// 2
;1187:					"[invalid var]",			// 3
;1188:					BotMapTitle(),				// 4
;1189:					BotRandomWeaponName(),		// 5
;1190:					NULL);
;1191:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 176
CNSTI4 0
ASGNI4
ADDRLP4 176
INDIRI4
ARGI4
ADDRLP4 176
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1192
;1192:	}
LABELV $700
line 1180
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $702
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $699
line 1193
;1193:	num = trap_BotNumInitialChats(bs->cs, "random_insult");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $588
ARGP4
ADDRLP4 160
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 160
INDIRI4
ASGNI4
line 1194
;1194:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $706
JUMPV
LABELV $703
line 1195
;1195:	{
line 1196
;1196:		BotAI_BotInitialChat(bs, "random_insult",
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 168
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRLP4 172
ADDRGP4 BotRandomWeaponName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $588
ARGP4
ADDRLP4 164
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 176
ADDRGP4 $268
ASGNP4
ADDRLP4 176
INDIRP4
ARGP4
ADDRLP4 176
INDIRP4
ARGP4
ADDRLP4 168
INDIRP4
ARGP4
ADDRLP4 172
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1204
;1197:					BotRandomOpponentName(bs),	// 0
;1198:					name,						// 1
;1199:					"[invalid var]",			// 2
;1200:					"[invalid var]",			// 3
;1201:					BotMapTitle(),				// 4
;1202:					BotRandomWeaponName(),		// 5
;1203:					NULL);
;1204:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 180
CNSTI4 0
ASGNI4
ADDRLP4 180
INDIRI4
ARGI4
ADDRLP4 180
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1205
;1205:	}
LABELV $704
line 1194
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $706
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $703
line 1206
;1206:}
LABELV $590
endproc BotChatTest 184 36
import BotDumpNodeSwitches
import BotResetNodeSwitches
import AINode_Battle_NBG
import AINode_Battle_Retreat
import AINode_Battle_Chase
import AINode_Battle_Fight
import AINode_Seek_LTG
import AINode_Seek_NBG
import AINode_Seek_ActivateEntity
import AINode_Stand
import AINode_Respawn
import AINode_Observer
import AINode_Intermission
import AIEnter_Battle_NBG
import AIEnter_Battle_Retreat
import AIEnter_Battle_Chase
import AIEnter_Battle_Fight
import AIEnter_Seek_Camp
import AIEnter_Seek_LTG
import AIEnter_Seek_NBG
import AIEnter_Seek_ActivateEntity
import AIEnter_Stand
import AIEnter_Respawn
import AIEnter_Observer
import AIEnter_Intermission
import BotPrintTeamGoal
import BotMatchMessage
import notleader
import ctf_blueflag
import ctf_redflag
import bot_challenge
import bot_testrchat
import bot_nochat
import bot_fastchat
import bot_rocketjump
import bot_grapple
import maxclients
import gametype
import BotMapScripts
import BotPointAreaNum
import ClientOnSameTeamFromName
import ClientFromName
import stristr
import BotFindWayPoint
import BotCreateWayPoint
import BotAlternateRoute
import BotGetAlternateRouteGoal
import BotCTFRetreatGoals
import BotCTFSeekGoals
import BotRememberLastOrderedTask
import BotCTFCarryingFlag
import BotOppositeTeam
import BotTeam
import BotClearActivateGoalStack
import BotPopFromActivateGoalStack
import BotEnableActivateGoalAreas
import BotAIPredictObstacles
import BotAIBlocked
import BotCheckAttack
import BotAimAtEnemy
import BotEntityVisible
import BotRoamGoal
import BotFindEnemy
import InFieldOfVision
import BotVisibleTeamMatesAndEnemies
import BotEnemyFlagCarrierVisible
import BotTeamFlagCarrierVisible
import BotTeamFlagCarrier
import TeamPlayIsOn
import BotSameTeam
import BotAttackMove
import BotWantsToCamp
import BotHasPersistantPowerupAndWeapon
import BotCanAndWantsToRocketJump
import BotWantsToHelp
import BotWantsToChase
import BotWantsToRetreat
import BotFeelingBad
import BotAggression
import BotTeamGoals
import BotSetLastOrderedTask
import BotSynonymContext
import ClientSkin
import EasyClientName
import ClientName
import BotSetTeamStatus
import BotSetUserInfo
import EntityIsShooting
import EntityIsInvisible
import EntityIsDead
import BotInLavaOrSlime
import BotIntermission
import BotIsObserver
import BotIsDead
import BotBattleUseItems
import BotUpdateBattleInventory
import BotUpdateInventory
import BotSetupForMovement
import BotChooseWeapon
import BotFreeWaypoints
import BotDeathmatchAI
import BotShutdownDeathmatchAI
import BotSetupDeathmatchAI
import BotTeamLeader
import BotAI_GetSnapshotEntity
import BotAI_GetEntityState
import BotAI_GetClientState
import BotAI_Trace
import BotAI_BotInitialChat
import BotAI_Print
import floattime
import BotEntityInfo
import NumBots
import BotResetState
import BotResetWeaponState
import BotFreeWeaponState
import BotAllocWeaponState
import BotLoadWeaponWeights
import BotGetWeaponInfo
import BotChooseBestFightWeapon
import BotShutdownWeaponAI
import BotSetupWeaponAI
import BotShutdownMoveAI
import BotSetupMoveAI
import BotSetBrushModelTypes
import BotAddAvoidSpot
import BotInitMoveState
import BotFreeMoveState
import BotAllocMoveState
import BotPredictVisiblePosition
import BotMovementViewTarget
import BotReachabilityArea
import BotResetLastAvoidReach
import BotResetAvoidReach
import BotMoveInDirection
import BotMoveToGoal
import BotResetMoveState
import BotShutdownGoalAI
import BotSetupGoalAI
import BotFreeGoalState
import BotAllocGoalState
import BotFreeItemWeights
import BotLoadItemWeights
import BotMutateGoalFuzzyLogic
import BotSaveGoalFuzzyLogic
import BotInterbreedGoalFuzzyLogic
import BotUpdateEntityItems
import BotInitLevelItems
import BotSetAvoidGoalTime
import BotAvoidGoalTime
import BotGetMapLocationGoal
import BotGetNextCampSpotGoal
import BotGetLevelItemGoal
import BotItemGoalInVisButNotVisible
import BotTouchingGoal
import BotChooseNBGItem
import BotChooseLTGItem
import BotGetSecondGoal
import BotGetTopGoal
import BotGoalName
import BotDumpGoalStack
import BotDumpAvoidGoals
import BotEmptyGoalStack
import BotPopGoal
import BotPushGoal
import BotRemoveFromAvoidGoals
import BotResetAvoidGoals
import BotResetGoalState
import GeneticParentsAndChildSelection
import BotSetChatName
import BotSetChatGender
import BotLoadChatFile
import BotReplaceSynonyms
import UnifyWhiteSpaces
import BotMatchVariable
import BotFindMatch
import StringContains
import BotGetChatMessage
import BotEnterChat
import BotChatLength
import BotReplyChat
import BotNumInitialChats
import BotInitialChat
import BotNumConsoleMessages
import BotNextConsoleMessage
import BotRemoveConsoleMessage
import BotQueueConsoleMessage
import BotFreeChatState
import BotAllocChatState
import BotShutdownChatAI
import BotSetupChatAI
import BotShutdownCharacters
import Characteristic_String
import Characteristic_BInteger
import Characteristic_Integer
import Characteristic_BFloat
import Characteristic_Float
import BotFreeCharacter
import BotLoadCharacter
import EA_Shutdown
import EA_Setup
import EA_ResetInput
import EA_GetInput
import EA_EndRegular
import EA_View
import EA_Move
import EA_DelayedJump
import EA_Jump
import EA_SelectWeapon
import EA_Use
import EA_Gesture
import EA_Talk
import EA_Respawn
import EA_Attack
import EA_MoveRight
import EA_MoveLeft
import EA_MoveBack
import EA_MoveForward
import EA_MoveDown
import EA_MoveUp
import EA_Walk
import EA_Crouch
import EA_Action
import EA_Command
import EA_SayTeam
import EA_Say
import GetBotLibAPI
import trap_SnapVector
import trap_GeneticParentsAndChildSelection
import trap_BotResetWeaponState
import trap_BotFreeWeaponState
import trap_BotAllocWeaponState
import trap_BotLoadWeaponWeights
import trap_BotGetWeaponInfo
import trap_BotChooseBestFightWeapon
import trap_BotAddAvoidSpot
import trap_BotInitMoveState
import trap_BotFreeMoveState
import trap_BotAllocMoveState
import trap_BotPredictVisiblePosition
import trap_BotMovementViewTarget
import trap_BotReachabilityArea
import trap_BotResetLastAvoidReach
import trap_BotResetAvoidReach
import trap_BotMoveInDirection
import trap_BotMoveToGoal
import trap_BotResetMoveState
import trap_BotFreeGoalState
import trap_BotAllocGoalState
import trap_BotMutateGoalFuzzyLogic
import trap_BotSaveGoalFuzzyLogic
import trap_BotInterbreedGoalFuzzyLogic
import trap_BotFreeItemWeights
import trap_BotLoadItemWeights
import trap_BotUpdateEntityItems
import trap_BotInitLevelItems
import trap_BotSetAvoidGoalTime
import trap_BotAvoidGoalTime
import trap_BotGetLevelItemGoal
import trap_BotGetMapLocationGoal
import trap_BotGetNextCampSpotGoal
import trap_BotItemGoalInVisButNotVisible
import trap_BotTouchingGoal
import trap_BotChooseNBGItem
import trap_BotChooseLTGItem
import trap_BotGetSecondGoal
import trap_BotGetTopGoal
import trap_BotGoalName
import trap_BotDumpGoalStack
import trap_BotDumpAvoidGoals
import trap_BotEmptyGoalStack
import trap_BotPopGoal
import trap_BotPushGoal
import trap_BotResetAvoidGoals
import trap_BotRemoveFromAvoidGoals
import trap_BotResetGoalState
import trap_BotSetChatName
import trap_BotSetChatGender
import trap_BotLoadChatFile
import trap_BotReplaceSynonyms
import trap_UnifyWhiteSpaces
import trap_BotMatchVariable
import trap_BotFindMatch
import trap_StringContains
import trap_BotGetChatMessage
import trap_BotEnterChat
import trap_BotChatLength
import trap_BotReplyChat
import trap_BotNumInitialChats
import trap_BotInitialChat
import trap_BotNumConsoleMessages
import trap_BotNextConsoleMessage
import trap_BotRemoveConsoleMessage
import trap_BotQueueConsoleMessage
import trap_BotFreeChatState
import trap_BotAllocChatState
import trap_Characteristic_String
import trap_Characteristic_BInteger
import trap_Characteristic_Integer
import trap_Characteristic_BFloat
import trap_Characteristic_Float
import trap_BotFreeCharacter
import trap_BotLoadCharacter
import trap_EA_ResetInput
import trap_EA_GetInput
import trap_EA_EndRegular
import trap_EA_View
import trap_EA_Move
import trap_EA_DelayedJump
import trap_EA_Jump
import trap_EA_SelectWeapon
import trap_EA_MoveRight
import trap_EA_MoveLeft
import trap_EA_MoveBack
import trap_EA_MoveForward
import trap_EA_MoveDown
import trap_EA_MoveUp
import trap_EA_Crouch
import trap_EA_Respawn
import trap_EA_Use
import trap_EA_Attack
import trap_EA_Talk
import trap_EA_Gesture
import trap_EA_Action
import trap_EA_Command
import trap_EA_SayTeam
import trap_EA_Say
import trap_AAS_PredictClientMovement
import trap_AAS_Swimming
import trap_AAS_AlternativeRouteGoals
import trap_AAS_PredictRoute
import trap_AAS_EnableRoutingArea
import trap_AAS_AreaTravelTimeToGoalArea
import trap_AAS_AreaReachability
import trap_AAS_IntForBSPEpairKey
import trap_AAS_FloatForBSPEpairKey
import trap_AAS_VectorForBSPEpairKey
import trap_AAS_ValueForBSPEpairKey
import trap_AAS_NextBSPEntity
import trap_AAS_PointContents
import trap_AAS_TraceAreas
import trap_AAS_PointReachabilityAreaIndex
import trap_AAS_PointAreaNum
import trap_AAS_Time
import trap_AAS_PresenceTypeBoundingBox
import trap_AAS_Initialized
import trap_AAS_EntityInfo
import trap_AAS_AreaInfo
import trap_AAS_BBoxAreas
import trap_BotUserCommand
import trap_BotGetServerCommand
import trap_BotGetSnapshotEntity
import trap_BotLibTest
import trap_BotLibUpdateEntity
import trap_BotLibLoadMap
import trap_BotLibStartFrame
import trap_BotLibDefine
import trap_BotLibVarGet
import trap_BotLibVarSet
import trap_BotLibShutdown
import trap_BotLibSetup
import trap_DebugPolygonDelete
import trap_DebugPolygonCreate
import trap_GetEntityToken
import trap_GetUsercmd
import trap_BotFreeClient
import trap_BotAllocateClient
import trap_EntityContact
import trap_EntitiesInBox
import trap_UnlinkEntity
import trap_LinkEntity
import trap_AreasConnected
import trap_AdjustAreaPortalState
import trap_InPVSIgnorePortals
import trap_InPVS
import trap_PointContents
import trap_Trace
import trap_SetBrushModel
import trap_GetServerinfo
import trap_SetUserinfo
import trap_GetUserinfo
import trap_GetConfigstring
import trap_SetConfigstring
import trap_SendServerCommand
import trap_DropClient
import trap_LocateGameData
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_VariableIntegerValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_Milliseconds
import trap_Error
import trap_Printf
import g_proxMineTimeout
import g_singlePlayer
import g_enableBreath
import g_enableDust
import g_rankings
import pmove_msec
import pmove_fixed
import g_smoothClients
import g_blueteam
import g_redteam
import g_cubeTimeout
import g_obeliskRespawnDelay
import g_obeliskRegenAmount
import g_obeliskRegenPeriod
import g_obeliskHealth
import g_filterBan
import g_banIPs
import g_teamForceBalance
import g_teamAutoJoin
import g_allowVote
import g_blood
import g_doWarmup
import g_warmup
import g_motd
import g_synchronousClients
import g_weaponTeamRespawn
import g_weaponRespawn
import g_debugDamage
import g_debugAlloc
import g_debugMove
import g_inactivity
import g_forcerespawn
import g_quadfactor
import g_knockback
import g_speed
import g_gravity
import g_needpass
import g_password
import g_friendlyFire
import g_capturelimit
import g_timelimit
import g_fraglimit
import g_dmflags
import g_restarted
import g_maxGameClients
import g_maxclients
import g_cheats
import g_dedicated
import g_gametype
import g_entities
import level
import Pickup_Team
import CheckTeamStatus
import TeamplayInfoMessage
import Team_GetLocationMsg
import Team_GetLocation
import SelectCTFSpawnPoint
import Team_FreeEntity
import Team_ReturnFlag
import Team_InitGame
import Team_CheckHurtCarrier
import Team_FragBonuses
import Team_DroppedFlagThink
import AddTeamScore
import TeamColorString
import OtherTeamName
import TeamName
import OtherTeam
import BotTestAAS
import BotAIStartFrame
import BotAIShutdownClient
import BotAISetupClient
import BotAILoadMap
import BotAIShutdown
import BotAISetup
import BotInterbreedEndMatch
import Svcmd_BotList_f
import Svcmd_AddBot_f
import G_BotConnect
import G_RemoveQueuedBotBegin
import G_CheckBotSpawn
import G_GetBotInfoByName
import G_GetBotInfoByNumber
import G_InitBots
import Svcmd_AbortPodium_f
import SpawnModelsOnVictoryPads
import UpdateTournamentInfo
import G_WriteSessionData
import G_InitWorldSession
import G_InitSessionData
import G_ReadSessionData
import Svcmd_GameMem_f
import G_InitMemory
import G_Alloc
import CheckObeliskAttack
import Team_CheckDroppedItem
import OnSameTeam
import G_RunClient
import ClientEndFrame
import ClientThink
import ClientCommand
import ClientBegin
import ClientDisconnect
import ClientUserinfoChanged
import ClientConnect
import G_Error
import G_Printf
import SendScoreboardMessageToAllClients
import G_LogPrintf
import G_RunThink
import CheckTeamLeader
import SetLeader
import FindIntermissionPoint
import DeathmatchScoreboardMessage
import G_SetStats
import MoveClientToIntermission
import FireWeapon
import G_FilterPacket
import G_ProcessIPBans
import ConsoleCommand
import SpotWouldTelefrag
import CalculateRanks
import AddScore
import player_die
import ClientSpawn
import InitBodyQue
import InitClientResp
import InitClientPersistant
import BeginIntermission
import respawn
import CopyToBodyQue
import SelectSpawnPoint
import SetClientViewAngle
import PickTeam
import TeamLeader
import TeamCount
import Weapon_HookThink
import Weapon_HookFree
import CheckGauntletAttack
import SnapVectorTowards
import CalcMuzzlePoint
import LogAccuracyHit
import TeleportPlayer
import trigger_teleporter_touch
import Touch_DoorTrigger
import G_RunMover
import fire_grapple
import fire_bfg
import fire_rocket
import fire_grenade
import fire_plasma
import fire_blaster
import G_RunMissile
import TossClientCubes
import TossClientItems
import body_die
import G_InvulnerabilityEffect
import G_RadiusDamage
import G_Damage
import CanDamage
import BuildShaderStateConfig
import AddRemap
import G_SetOrigin
import G_AddEvent
import G_AddPredictableEvent
import vectoyaw
import vtos
import tv
import G_TouchSolids
import G_TouchTriggers
import G_EntitiesFree
import G_FreeEntity
import G_Sound
import G_TempEntity
import G_Spawn
import G_InitGentity
import G_SetMovedir
import G_UseTargets
import G_PickTarget
import G_Find
import G_KillBox
import G_TeamCommand
import G_SoundIndex
import G_ModelIndex
import SaveRegisteredItems
import RegisterItem
import ClearRegisteredItems
import Touch_Item
import Add_Ammo
import ArmorIndex
import Think_Weapon
import FinishSpawningItem
import G_SpawnItem
import SetRespawn
import LaunchItem
import Drop_Item
import PrecacheItem
import UseHoldableItem
import RespawnItem
import G_RunItem
import G_CheckTeamItems
import Cmd_FollowCycle_f
import SetTeam
import BroadcastTeamChange
import StopFollowing
import Cmd_Score_f
import G_NewString
import G_SpawnEntitiesFromString
import G_SpawnVector
import G_SpawnInt
import G_SpawnFloat
import G_SpawnString
import BG_PlayerTouchesItem
import BG_PlayerStateToEntityStateExtraPolate
import BG_PlayerStateToEntityState
import BG_TouchJumpPad
import BG_AddPredictableEventToPlayerstate
import BG_EvaluateTrajectoryDelta
import BG_EvaluateTrajectory
import BG_CanItemBeGrabbed
import BG_FindItemForHoldable
import BG_FindItemForPowerup
import BG_FindItemForWeapon
import BG_FindItem
import bg_numItems
import bg_itemlist
import Pmove
import PM_UpdateViewAngles
import Com_Printf
import Com_Error
import Info_NextPair
import Info_Validate
import Info_SetValueForKey_Big
import Info_SetValueForKey
import Info_RemoveKey_big
import Info_RemoveKey
import Info_ValueForKey
import va
import Q_CleanStr
import Q_PrintStrlen
import Q_strcat
import Q_strncpyz
import Q_strrchr
import Q_strupr
import Q_strlwr
import Q_stricmpn
import Q_strncmp
import Q_stricmp
import Q_isalpha
import Q_isupper
import Q_islower
import Q_isprint
import Com_sprintf
import Parse3DMatrix
import Parse2DMatrix
import Parse1DMatrix
import SkipRestOfLine
import SkipBracedSection
import COM_MatchToken
import COM_ParseWarning
import COM_ParseError
import COM_Compress
import COM_ParseExt
import COM_Parse
import COM_GetCurrentParseLine
import COM_BeginParseSession
import COM_DefaultExtension
import COM_StripExtension
import COM_SkipPath
import Com_Clamp
import PerpendicularVector
import AngleVectors
import MatrixMultiply
import MakeNormalVectors
import RotateAroundDirection
import RotatePointAroundVector
import ProjectPointOnPlane
import PlaneFromPoints
import AngleDelta
import AngleNormalize180
import AngleNormalize360
import AnglesSubtract
import AngleSubtract
import LerpAngle
import AngleMod
import BoxOnPlaneSide
import SetPlaneSignbits
import AxisCopy
import AxisClear
import AnglesToAxis
import vectoangles
import Q_crandom
import Q_random
import Q_rand
import Q_acos
import Q_log2
import VectorRotate
import Vector4Scale
import VectorNormalize2
import VectorNormalize
import CrossProduct
import VectorInverse
import VectorNormalizeFast
import DistanceSquared
import Distance
import VectorLengthSquared
import VectorLength
import VectorCompare
import AddPointToBounds
import ClearBounds
import RadiusFromBounds
import NormalizeColor
import ColorBytes4
import ColorBytes3
import _VectorMA
import _VectorScale
import _VectorCopy
import _VectorAdd
import _VectorSubtract
import _DotProduct
import ByteToDir
import DirToByte
import ClampShort
import ClampChar
import Q_rsqrt
import Q_fabs
import axisDefault
import vec3_origin
import g_color_table
import colorDkGrey
import colorMdGrey
import colorLtGrey
import colorWhite
import colorCyan
import colorMagenta
import colorYellow
import colorBlue
import colorGreen
import colorRed
import colorBlack
import bytedirs
import Com_Memcpy
import Com_Memset
import Hunk_Alloc
import FloatSwap
import LongSwap
import ShortSwap
import acos
import fabs
import abs
import tan
import atan2
import cos
import sin
import sqrt
import floor
import ceil
import memcpy
import memset
import memmove
import sscanf
import vsprintf
import _atoi
import atoi
import _atof
import atof
import toupper
import tolower
import strncpy
import strstr
import strchr
import strcmp
import strcpy
import strcat
import strlen
import rand
import srand
import qsort
lit
align 1
LABELV $588
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 95
byte 1 105
byte 1 110
byte 1 115
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $587
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 95
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 0
align 1
LABELV $551
byte 1 104
byte 1 105
byte 1 116
byte 1 95
byte 1 110
byte 1 111
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $526
byte 1 104
byte 1 105
byte 1 116
byte 1 95
byte 1 110
byte 1 111
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $493
byte 1 104
byte 1 105
byte 1 116
byte 1 95
byte 1 116
byte 1 97
byte 1 108
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $463
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 95
byte 1 115
byte 1 117
byte 1 105
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $462
byte 1 0
align 1
LABELV $438
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 112
byte 1 114
byte 1 97
byte 1 105
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $437
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 105
byte 1 110
byte 1 115
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $434
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $431
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $428
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 103
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $423
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 109
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $399
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 112
byte 1 114
byte 1 97
byte 1 105
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $398
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 105
byte 1 110
byte 1 115
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $395
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 98
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $394
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $391
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 103
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $383
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $380
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 115
byte 1 117
byte 1 105
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $372
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 99
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $369
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 108
byte 1 97
byte 1 118
byte 1 97
byte 1 0
align 1
LABELV $366
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 115
byte 1 108
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $363
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 100
byte 1 114
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $358
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 109
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $353
byte 1 91
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 93
byte 1 0
align 1
LABELV $335
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 95
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $334
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 95
byte 1 101
byte 1 110
byte 1 100
byte 1 95
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $331
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 95
byte 1 101
byte 1 110
byte 1 100
byte 1 95
byte 1 118
byte 1 105
byte 1 99
byte 1 116
byte 1 111
byte 1 114
byte 1 121
byte 1 0
align 1
LABELV $307
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $297
byte 1 118
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $286
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 95
byte 1 101
byte 1 120
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $268
byte 1 91
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 118
byte 1 97
byte 1 114
byte 1 93
byte 1 0
align 1
LABELV $267
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 95
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $194
byte 1 91
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 93
byte 1 0
align 1
LABELV $193
byte 1 71
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $191
byte 1 66
byte 1 70
byte 1 71
byte 1 49
byte 1 48
byte 1 75
byte 1 0
align 1
LABELV $189
byte 1 76
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $187
byte 1 82
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $185
byte 1 80
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $183
byte 1 82
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 32
byte 1 76
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $181
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 76
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $179
byte 1 77
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $177
byte 1 71
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $175
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $169
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $68
byte 1 116
byte 1 0
align 1
LABELV $64
byte 1 110
byte 1 0
align 1
LABELV $57
byte 1 115
byte 1 118
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
