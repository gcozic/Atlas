#ifndef INMODULE
#define INMODULE

#define constFlitSize 16
#define constNumRot 9
#define constNumRotX 3
#define constNumRotY 3
#define constNumberOfChars 4

#include <stdio.h>
#include <string.h>
#include <systemc.h>

SC_MODULE(inputmodule)
{
	sc_in<sc_logic> clock;
	sc_in<sc_logic> reset;
	sc_out<sc_logic> finish;
	sc_out<sc_logic> outtx0;
	sc_out<sc_lv<constFlitSize> > outdata0;
	sc_in<sc_logic> inack0;
	sc_out<sc_logic> outtx1;
	sc_out<sc_lv<constFlitSize> > outdata1;
	sc_in<sc_logic> inack1;
	sc_out<sc_logic> outtx2;
	sc_out<sc_lv<constFlitSize> > outdata2;
	sc_in<sc_logic> inack2;
	sc_out<sc_logic> outtx3;
	sc_out<sc_lv<constFlitSize> > outdata3;
	sc_in<sc_logic> inack3;
	sc_out<sc_logic> outtx4;
	sc_out<sc_lv<constFlitSize> > outdata4;
	sc_in<sc_logic> inack4;
	sc_out<sc_logic> outtx5;
	sc_out<sc_lv<constFlitSize> > outdata5;
	sc_in<sc_logic> inack5;
	sc_out<sc_logic> outtx6;
	sc_out<sc_lv<constFlitSize> > outdata6;
	sc_in<sc_logic> inack6;
	sc_out<sc_logic> outtx7;
	sc_out<sc_lv<constFlitSize> > outdata7;
	sc_in<sc_logic> inack7;
	sc_out<sc_logic> outtx8;
	sc_out<sc_lv<constFlitSize> > outdata8;
	sc_in<sc_logic> inack8;

	void inline outTx(int Indice, int Booleano){
		if(Indice == 0) outtx0 = (Booleano != 0)? SC_LOGIC_1: SC_LOGIC_0;
		else if(Indice == 1) outtx1 = (Booleano != 0)? SC_LOGIC_1: SC_LOGIC_0;
		else if(Indice == 2) outtx2 = (Booleano != 0)? SC_LOGIC_1: SC_LOGIC_0;
		else if(Indice == 3) outtx3 = (Booleano != 0)? SC_LOGIC_1: SC_LOGIC_0;
		else if(Indice == 4) outtx4 = (Booleano != 0)? SC_LOGIC_1: SC_LOGIC_0;
		else if(Indice == 5) outtx5 = (Booleano != 0)? SC_LOGIC_1: SC_LOGIC_0;
		else if(Indice == 6) outtx6 = (Booleano != 0)? SC_LOGIC_1: SC_LOGIC_0;
		else if(Indice == 7) outtx7 = (Booleano != 0)? SC_LOGIC_1: SC_LOGIC_0;
		else if(Indice == 8) outtx8 = (Booleano != 0)? SC_LOGIC_1: SC_LOGIC_0;
	}

	void inline outData(int Indice, unsigned long int Valor){
		if(Indice == 0) outdata0 = Valor;
		else if(Indice == 1) outdata1 = Valor;
		else if(Indice == 2) outdata2 = Valor;
		else if(Indice == 3) outdata3 = Valor;
		else if(Indice == 4) outdata4 = Valor;
		else if(Indice == 5) outdata5 = Valor;
		else if(Indice == 6) outdata6 = Valor;
		else if(Indice == 7) outdata7 = Valor;
		else if(Indice == 8) outdata8 = Valor;
	}

	int inline inAck(int Indice){
		if(Indice == 0) return (inack0 == SC_LOGIC_1)? 1 : 0;
		if(Indice == 1) return (inack1 == SC_LOGIC_1)? 1 : 0;
		if(Indice == 2) return (inack2 == SC_LOGIC_1)? 1 : 0;
		if(Indice == 3) return (inack3 == SC_LOGIC_1)? 1 : 0;
		if(Indice == 4) return (inack4 == SC_LOGIC_1)? 1 : 0;
		if(Indice == 5) return (inack5 == SC_LOGIC_1)? 1 : 0;
		if(Indice == 6) return (inack6 == SC_LOGIC_1)? 1 : 0;
		if(Indice == 7) return (inack7 == SC_LOGIC_1)? 1 : 0;
		if(Indice == 8) return (inack8 == SC_LOGIC_1)? 1 : 0;
	}

	unsigned long int CurrentTime;
	void inline Timer();
	void inline TrafficGenerator();

	SC_CTOR(inputmodule):
	outtx0("outtx0"),
	outdata0("outdata0"),
	inack0("inack0"),
	outtx1("outtx1"),
	outdata1("outdata1"),
	inack1("inack1"),
	outtx2("outtx2"),
	outdata2("outdata2"),
	inack2("inack2"),
	outtx3("outtx3"),
	outdata3("outdata3"),
	inack3("inack3"),
	outtx4("outtx4"),
	outdata4("outdata4"),
	inack4("inack4"),
	outtx5("outtx5"),
	outdata5("outdata5"),
	inack5("inack5"),
	outtx6("outtx6"),
	outdata6("outdata6"),
	inack6("inack6"),
	outtx7("outtx7"),
	outdata7("outdata7"),
	inack7("inack7"),
	outtx8("outtx8"),
	outdata8("outdata8"),
	inack8("inack8"),
	reset("reset"),
 	clock("clock")
	{
		CurrentTime = 0;
		SC_CTHREAD(TrafficGenerator, clock.pos());
		//watching(reset.delayed() == true);

		SC_METHOD(Timer);
		sensitive_pos << clock;
		dont_initialize();
	}
};

void inline inputmodule::Timer(){
	++CurrentTime;
}

void inline inputmodule::TrafficGenerator(){
	enum Estado{S1, S2, S3, S4, S5, FimArquivo};
	CurrentTime = 0;
	FILE* Input[constNumRot];
	char temp[100];
	char Destino[constFlitSize/4+1];
	unsigned long int CurrentFlit[constNumRot], Desnecessaria[constNumRot][100], TSSaida[constNumRot], Temp;
	unsigned long int* BigPacket[constNumRot];
	bool Mandando[constNumRot], Ajeitando[constNumRot];
	Estado EstadoAtual[constNumRot];
	int FlitNumber[constNumRot], NumberofFlits[constNumRot], WaitTime[constNumRot];
	int Index,i,j,k;
	bool active[constNumRot];
	int n_active = 0;

	for(Index=0;Index<constNumRot;Index++){
		outTx(Index, 0);
		sprintf(temp,"in%d.txt",Index);
		Input[Index] = fopen(temp,"r");
		if(Input[Index] != NULL){
			active[Index] = true;
			n_active++;
		}
		else{
			active[Index] = false;
		}
		EstadoAtual[Index] = S1;
		FlitNumber[Index] = 0;
	}

	while(true){
		for(Index=0;Index<constNumRot;Index++){
		  if(reset!=SC_LOGIC_1 && active[Index]){
				//captura o tempo para entrada na rede
				if(EstadoAtual[Index] == S1){
						outTx(Index,0);
						FlitNumber[Index] = 0;
						fscanf(Input[Index],"%X",&CurrentFlit[Index]);
						WaitTime[Index] = CurrentFlit[Index];
						EstadoAtual[Index]=S2;
						if(feof(Input[Index])){
							fclose(Input[Index]);
							active[Index] = false;
							n_active--;
							outTx(Index, 0);
							EstadoAtual[Index] = FimArquivo;
						}
				}
				//espera atý o tempo para entrar na rede
				if(EstadoAtual[Index] == S2){
					outTx(Index,0);

					// eh na verdade o Wait Time do Pacote Atual, do roteador escolhido.
					if(CurrentTime<WaitTime[Index]){
						EstadoAtual[Index]=S2;
					}
					else{
						EstadoAtual[Index] = S3;
					}
				}
				if(EstadoAtual[Index]== S3){
					outTx(Index,0);
					//lendo os dois primeiros flits
					while(FlitNumber[Index] < 2){
						fscanf(Input[Index],"%X",&CurrentFlit[Index]);
						Desnecessaria[Index][FlitNumber[Index] ] = CurrentFlit[Index] ;
						if(FlitNumber[Index] == 1){
							// numero de flits que vai ter o TS de Entrada na Rede.
							Desnecessaria[Index][1]+= 4;
							NumberofFlits[Index] = Desnecessaria[Index][1];///////////////////////////precisa de +2 para o destino e tamanhoq ue sýo flits que nao contam,
							BigPacket[Index]=(unsigned long int*)calloc( sizeof(unsigned long int) , (2 + Desnecessaria[Index][1]));
							BigPacket[Index][0] = Desnecessaria[Index][0];
							BigPacket[Index][1] = Desnecessaria[Index][1];
						}
						FlitNumber[Index]++;
					}

					//lendo os flits atý o nýmero de sequencia
					while(FlitNumber[Index] < 9 ){
						fscanf(Input[Index], "%X", &CurrentFlit[Index]);
						BigPacket[Index][FlitNumber[Index] ] = CurrentFlit[Index];
						FlitNumber[Index]++;
					}

					FlitNumber[Index]+=4; //eh o espaco que depois vai ter o TS de entrada na rede =)

					//lendo os flits de payload
					while(FlitNumber[Index] < NumberofFlits[Index] + 2 ){ //2 ý Target + Size
						fscanf(Input[Index], "%X", &CurrentFlit[Index]);
						BigPacket[Index][FlitNumber[Index] ] = CurrentFlit[Index];
						FlitNumber[Index]++;
					}
					EstadoAtual[Index] = S4;

					FlitNumber[Index]=-1; //Necessario, porque ele incrementa isso antes de mandar o primero, assim ele consegue realmente mandar todos os flits.
				}
				//comeca a transmitir os dados
				if(EstadoAtual[Index]==S4){
					if(inAck(Index) == 0){
						if(FlitNumber[Index]>NumberofFlits[Index]){
							outTx(Index, 0);
							EstadoAtual[Index] = S1;
							free(BigPacket[Index]);
						}
						else{
							FlitNumber[Index]++;
							if(FlitNumber[Index] == 0)  TSSaida[Index] = CurrentTime;
							if(FlitNumber[Index] == 9){
								Temp = FlitNumber[Index];
								sprintf(temp, "%0*X",constFlitSize, TSSaida[Index]); // Obs que nao atrapalha mas tambem nao ajuda: o maximo do unsigned long int ý 32 bits, ou seja FFFF FFFF.

								for(i=0,j=0;i<constFlitSize;i++,j++){
									Destino[j]=temp[i];
									if(j==constFlitSize/4-1){
										sscanf(Destino, "%X", &BigPacket[Index][Temp ]); // (5 + constNumberOfChars) + k]);
										j=-1; //  porque na iteracao seguinte vai aumentar 1.
										Temp++;
									}
								}
							} //Aqui ele efetivamente Adicona o TS de Saida

							if( !feof(Input[Index]) ) outTx(Index, 1);
							outData(Index, BigPacket[Index][FlitNumber[Index] ]);
							EstadoAtual[Index]=S5;
						}
					}
					else{
						outTx(Index, 0);
						EstadoAtual[Index] = S5;
					}
				}
				else if(EstadoAtual[Index]==S5){
					if(inAck(Index)==1){
						outTx(Index, 0);
						if(FlitNumber[Index]>NumberofFlits[Index]){
							EstadoAtual[Index] = S1;
							free(BigPacket[Index]);
						}
						else{
							EstadoAtual[Index] = S4;
						}
					}
					else EstadoAtual[Index] = S5;

				}
				if(EstadoAtual[Index] == FimArquivo){
					outTx(Index, 0);
				}
		    }//end if active
		}//end for
		finish = (n_active==0)? SC_LOGIC_1: SC_LOGIC_0;
		wait();
	}//end while
}

#endif// INMODULE
