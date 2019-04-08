#include<unistd.h>
#include<stdio.h>
#include<sys/types.h>
#include<sys/wait.h>
#include<pthread.h>
#include<stdlib.h>

#define min_pid 100
#define max_pid 1000
#define no_of_pid 900

int a=0;
int bitmap[no_of_pid];

int allocate_map();
int allocate_pid(int exe_time);
int release_pid(int);
int total_available();
int next_available();
void *create_mul_process(void *exe_time);
void optionA();
void optionB();

int allocate_map(){
	if(1){
	int q;
	for(q=0;q<no_of_pid;q++){
	bitmap[q]=0;
	}
	printf("\n pid's avaialble from %d to %d\n",min_pid,max_pid);
	return 1;
	}
	else{
	return -1;
	}}


int total_available(){
	int t=0;
	int q;
	for(q=0;q<no_of_pid;q++){
		if(bitmap[q]==0)
		t++;
	}
	return t;
}

int next_available(){
int q;
	for(q=0;q<no_of_pid;q++){
		if(bitmap[q]==0){
		int pid=min_pid+q;
		return pid;
		}
}
}

void *create_mul_process(void *time){
	int pid;
	int exe_time=*(int *)time;
	pid=allocate_pid(exe_time);
	sleep(exe_time);
	release_pid(pid);
	return NULL;
}

int allocate_pid(int exe_time){
int pid;
for(int q=0;q<no_of_pid;q++){
	if(bitmap[q]==0){
		pid=min_pid+q;
	bitmap[q]=1;
	break;
}
}
printf("process pid : %d\n",pid);
a++;
return pid;
}

int release_pid(int pid){
int q=pid-min_pid;
	if(bitmap[q]==1){
	bitmap[q]=0;
}
printf("process terminated,released pid is %d\n",pid);
return 1;
}


void optionA(){
printf("choose any option\n");
printf("\n press 1 to find no.of pid's available\n");
printf("\n press 2 to find  next available pid\n");
printf("\n press 3  to  create multiple process \n");
optionB();
}

void optionB(){
a=0;
int i;
//printf("choose an option\n");
scanf("%d",&i);
switch(i){

case 1:
	{int total_pid=total_available();
	printf("\n total available ids :%d",total_pid);
	optionA();}

case 2:
	{int next_id=next_available();
	printf("\n next available pid:%d",next_id);
	optionA();}

case 3:
	{int exe_time,n;
	printf("\n to create process  enter exe_time to terminate and no.of process\n");
	scanf("%d %d",&exe_time,&n);
	int measure=total_available();
	if(n>0 && n<=measure && exe_time>0){
		printf("\n process creation successful with exe_time: %d\n",exe_time);
		for(int j=0;j<n;j++){
		pthread_t p;
		pthread_create(&p,NULL,create_mul_process,&exe_time);
		}back:
		if(a!=n)
		goto back;
		optionA();
		}
		else{
		printf("\nError!Enter valid inputs\n");
		optionA();
		}
		}
default:
		{
		printf("you entererd wrong.Sorry!\n");
		exit(0);
		}
}
}
int main(){
int k;
printf("\n##########################################################\n");
printf("################# Welcome to  pid Manager#################\n");
printf("##########################################################\n");
allocate_map();
optionA();
printf("press 1 to exit\n");
scanf("%d",&k);
if(k==1){
printf("you entered exit\n");
exit(0);
}
}
