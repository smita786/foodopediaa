int reverse_write(char* input_file_name)
{
        int file=0;
       // char *file_name = input_file_name;
        if((file=open(input_file_name,O_RDONLY)) <= -1)
        {
                printf("couldn't open the file %s",input_file_name);
                return -1;
        }
        char buffer[16];
        int i;
        int fd;
        mode_t mode = S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH;
        char result_file_name[256] = "reverse_";
        reversed_file_name(input_file_name,result_file_name);
	char *originalString = (char *) malloc(sizeof(char)*4096);
	char reversedString[4096];
	originalString = "hey there i am";
	long int totNoChar = (long int)lseek(file,-1,SEEK_END);
	printf("total file size %ld",(long int)lseek(file,-1,SEEK_END));
	reverse_string(originalString,reversedString);
	printf("reversed string is %s",reversedString);
      //  char* filename = result_file_name;
	int bufferSize = 16;
        fd = open(result_file_name, O_WRONLY | O_CREAT,mode);
        for(i=-bufferSize;(int)lseek(file,i,SEEK_END) != -1;)
        {
		printf("i is %d and bufferSiz is %d",i,bufferSize);
        	if(read(file,buffer,bufferSize) != bufferSize)
        	{
                	printf("error in reading file %s",input_file_name);
          		return -1;
        	}
		reverse_string(buffer,reversedString);
        	if (write(fd, reversedString, bufferSize) != bufferSize) {
                	write(2, "error writing to output file\n", 30);
                	return -1;
        	}
		
        }
        return 1;
}
int reverse_string(char* originalString, char* reversedString)
{
	int i = 0;
	//char result_string[sizeof(originalString)];
	//reversedString = result_string;
	printf("original string is %s\n",originalString);
	while(*originalString)
	{
		originalString++;
		i++;
	}
	originalString--;
	int j = 0;
	while(i != 0)
	{
		reversedString[j] = *originalString;
	//	printf("making reverse %c\n",reversedString[j]);
		i--;
		j++;
		originalString--;
	}
	reversedString[j] = '\0';
	printf("in revers var value is %s\n",reversedString);
	return 1;
}
int reversed_file_name(char* original_file_name,char* result_file)
{
        int i = 0;
        while(result_file[i] != 0)
        {
                i++;
        }
        while(*original_file_name)
        {
                result_file[i] = *original_file_name;
                original_file_name++;
                i++;
        }
        result_file[i] = '\0';
        return 1;
}

