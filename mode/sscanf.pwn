SSCANF:dropmenu(string[])
{
	if(!strcmp(string,"add",true)) return 1;
	if(!strcmp(string,"create",true)) return 1;
	if(!strcmp(string,"delete",true)) return 2;
	if(!strcmp(string,"remove",true)) return 2;
	if(!strcmp(string,"destroy",true)) return 2;
	if(!strcmp(string,"respawn",true)) return 3;
	return 0;
}