#ifndef OUTMODULE
#define OUTMODULE

#define constFlitSize 16
#define constNumRot 9
#define constNumRotX 
#define constNumRotY 3

#include "systemc.h"
#include <stdio.h>
#include <string.h>
#include <sys/timeb.h>

SC_MODULE(outmodule)
{
	sc_in<sc_logic> clock;
	sc_in<sc_logic> reset;
	sc_in<sc_logic> finish;
	sc_in<sc_logic> intx0;
	sc_in<sc_lv<constFlitSize> > indata0;
	sc_in<sc_logic> intx1;
	sc_in<sc_lv<constFlitSize> > indata1;
	sc_in<sc_logic> intx2;
	sc_in<sc_lv<constFlitSize> > indata2;
	sc_in<sc_logic> intx3;
	sc_in<sc_lv<constFlitSize> > indata3;
	sc_in<sc_logic> intx4;
	sc_in<sc_lv<constFlitSize> > indata4;
	sc_in<sc_logic> intx5;
	sc_in<sc_lv<constFlitSize> > indata5;
	sc_in<sc_logic> intx6;
	sc_in<sc_lv<constFlitSize> > indata6;
	sc_in<sc_logic> intx7;
	sc_in<sc_lv<constFlitSize> > indata7;
	sc_in<sc_logic> intx8;
	sc_in<sc_lv<constFlitSize> > indata8;

	int  inTx(int Indice){
		if(Indice == 0) return (intx0 == SC_LOGIC_1)?1:0;
		if(Indice == 1) return (intx1 == SC_LOGIC_1)?1:0;
		if(Indice == 2) return (intx2 == SC_LOGIC_1)?1:0;
		if(Indice == 3) return (intx3 == SC_LOGIC_1)?1:0;
		if(Indice == 4) return (intx4 == SC_LOGIC_1)?1:0;
		if(Indice == 5) return (intx5 == SC_LOGIC_1)?1:0;
		if(Indice == 6) return (intx6 == SC_LOGIC_1)?1:0;
		if(Indice == 7) return (intx7 == SC_LOGIC_1)?1:0;
		if(Indice == 8) return (intx8 == SC_LOGIC_1)?1:0;
	}

	unsigned long int inData(int Indice){
		if(Indice == 0) return indata0.read().to_uint();
		if(Indice == 1) return indata1.read().to_uint();
		if(Indice == 2) return indata2.read().to_uint();
		if(Indice == 3) return indata3.read().to_uint();
		if(Indice == 4) return indata4.read().to_uint();
		if(Indice == 5) return indata5.read().to_uint();
		if(Indice == 6) return indata6.read().to_uint();
		if(Indice == 7) return indata7.read().to_uint();
		if(Indice == 8) return indata8.read().to_uint();
	}

	unsigned long int CurrentTime;

	void inline TrafficStalker();
	void inline Timer();

	SC_CTOR(outmodule) :
	intx0("intx0"),
	indata0("indata0"),
	intx1("intx1"),
	indata1("indata1"),
	intx2("intx2"),
	indata2("indata2"),
	intx3("intx3"),
	indata3("indata3"),
	intx4("intx4"),
	indata4("indata4"),
	intx5("intx5"),
	indata5("indata5"),
	intx6("intx6"),
	indata6("indata6"),
	intx7("intx7"),
	indata7("indata7"),
	intx8("intx8"),
	indata8("indata8"),
	reset("reset"),
	clock("clock")
	{
		CurrentTime = 0;

		SC_CTHREAD(TrafficStalker, clock.pos());
		//watching(reset.delayed()== true);

		SC_METHOD(Timer);
		sensitive_pos << clock;
		dont_initialize();
	}
};

void inline outmodule::Timer(){
	++CurrentTime;
}

void inline outmodule::TrafficStalker(){
//-----------------TIME--------------------------------//
	//declaracoes
	int segundos_inicial, milisegundos_inicial;
	int segundos_final, milisegundos_final;
	struct timeb tp;

	//captura o tempo
	ftime(&tp);
	//armazena o tempo inicial
	segundos_inicial=tp.time;
	milisegundos_inicial=tp.millitm;
//-----------------------------------------------------//
	//sc_set_default_time_unit(1,SC_NS);
	FILE* Output[constNumRot];
	CurrentTime = 0;
	bool transmitting = false;
	char temp[100], temp2[100], Destino[(int)constFlitSize/4+1];
	unsigned long int* Packet[constNumRot];
	unsigned long int CurrentFlit[constNumRot];
	unsigned long int PacketSize[constNumRot], J;
	unsigned long int Temp[constNumRot];
	unsigned long int Desnecessaria[constNumRot];
	unsigned long int TSCriacao[constNumRot], TSSaida[constNumRot];
	int Useless[constNumRot],i,j,k, Marca, Index, timeout;

	for(i=0; i<constNumRot; i++){
		sprintf(temp,"");
		sprintf(temp2,"out%d.txt",i);
		strcat(temp, temp2);

		Output[i] = fopen(temp,"w");
		Useless[i] = 0;
		PacketSize[i] = 0;
	}
	while(true){
		for(Index = 0; Index<constNumRot;Index++){
			if(inTx(Index)==1){
				transmitting = true;
				//Espera[Index] = true;
				CurrentFlit[Index] = (unsigned long int)inData(Index);
				if(Useless[Index] == 0){
					Desnecessaria[Index] = CurrentFlit[Index];
				}
				else if(Useless[Index] == 1){																							// Esses anexos sao para os dados que vem no fooooooter ( e alguns de tolerancia por via das duvidas ).
					Packet[Index] = (unsigned long int*)calloc(sizeof(unsigned long int), CurrentFlit[Index] + 11);
					PacketSize[Index] = CurrentFlit[Index] +2; //porque os dois flits iniciais, Destino e tamanho, nao contam.
					Packet[Index][0] = Desnecessaria[Index];
					Packet[Index][1] = CurrentFlit[Index];
				}
				else if(Useless[Index] < PacketSize[Index]){
					Packet[Index][Useless[Index] ] = CurrentFlit[Index];
				}

				++Useless[Index];
				Temp[Index] = CurrentTime;
			}


			if((Useless[Index] >= PacketSize[Index]) &&(Useless[Index] > 3)){

				////////////// TIMESTAMP de Saida da rede E TAL
				//%0*X, escreve em Hexa maiusculo com * caracteres, caso tiver menos, ý completado com 0's,
				//* ý um inteiro o prýximo argumento(no caso (constFlitSize/4), ou sendo FlitSize=16,
				//seria precedido de 0 atý completar 4 caracteres, se fosse 1, seria 0001, sendo 0 seria 0000 ) <- bem ýtil e usado pacas nesse cýdigo.
				sprintf(temp, "%0*X",constFlitSize, CurrentTime); // Obs que nao atrapalha mas tambem nao ajuda: o maximo do unsigned long int ý 32 bits, ou seja FFFF FFFF.

				for(i=0,j=0;i<constFlitSize;i++,j++){
					Destino[j]=temp[i];
					if(j==(constFlitSize/4)-1){
						sscanf(Destino, "%X", &Packet[Index][Useless[Index] ]); // (5 + constNumberOfChars) + k]);
						j=-1; //  porque na iteracao seguinte vai aumentar 1.
						Useless[Index]++;
					}
				}

				//TS de Criacao em decimal.
				Marca = 3;
				sprintf(temp, "");
				for(i=0;i<4;i++){
					//Marca eh o indice inicial em que esta o valor no header do pacote.
					sprintf(temp2, "%0*X",(int)(constFlitSize/4) ,Packet[Index][Marca + i]);
					strcat(temp, temp2);
				}
				sscanf(temp, "%X", &TSCriacao[Index] );//&Packet[Index][Useless[Index] ] );
				Packet[Index][Useless[Index] ] = TSCriacao[Index];
				Useless[Index]++;

				//TS de Entrada na rede em decimal
				Marca = 9;
				sprintf(temp, "");
				for(i=0;i<4;i++){
					sprintf(temp2, "%0*X",(int)(constFlitSize/4) ,Packet[Index][Marca + i]);
					strcat(temp, temp2);
				}
				sscanf(temp, "%X", &Packet[Index][Useless[Index] ] );
				Useless[Index]++;

				//TS de saida da rede em decimal
				TSSaida[Index] = (unsigned long int)CurrentTime;
				Packet[Index][Useless[Index] ] = TSSaida[Index];
				Useless[Index]++;

				//LATENCIA ( TS saida da rede - TSCriacao)
				Packet[Index][Useless[Index] ] = TSSaida[Index] - TSCriacao[Index];

				Useless[Index]++;

//-----------------TIME--------------------------------//Pega toda do FLI
				//captura o tempo de simulacao
				ftime(&tp);
				//armazena o tempo final
				segundos_final=tp.time;
				milisegundos_final=tp.millitm;
				Packet[Index][Useless[Index] ] = (unsigned long int)(segundos_final*1000 + milisegundos_final) - (segundos_inicial*1000+milisegundos_inicial);
				Useless[Index]++;
//-----------------/TIME--------------------------------//

				for(i=0;i<Useless[Index];i++){

					if(i<Useless[Index]-5){
						fprintf(Output[Index], "%0*X", (int)constFlitSize/4, Packet[Index][i]);
					}
					else{
						fprintf(Output[Index], "%u", Packet[Index][i]);
					}
					if(i<Useless[Index]-1){
						fprintf(Output[Index]," ");
					}
				}
				fprintf(Output[Index], "\n");
				Useless[Index] = 0;
				free (Packet[Index]);
				PacketSize[Index] = 0;
			}
		}
		if(finish==SC_LOGIC_1){
			if(transmitting) timeout=0;
			else{
				timeout++;
				if(timeout>1000) sc_stop();
			}
		}
		wait();
	}
}

#endif
