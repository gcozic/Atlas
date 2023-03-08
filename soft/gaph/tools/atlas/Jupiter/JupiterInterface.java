package Jupiter;

import java.awt.event.*;
import javax.swing.*;
import AtlasPackage.*;

/**
 * This class creates the Jupiter GUI allowing select the Mercury Torus2D NoC parameters and generate it.
 * @author Aline Vieira de Mello
 * @version
 */
public class JupiterInterface extends NoCGenerationGUI implements ActionListener{

	private Project project;
	private NoC noc;

	/**
	 * Constructor class.
	 * @param project The project where the NoC will be generated.
	 */
	public JupiterInterface(Project project){
		super("JUPITER 1.1  -  " + project.getStringProjFile());
		this.project = project;
		this.noc = project.getNoC();
		addComponents();
		super.setVisible(true);
	}

	/**
	 * Add components in the HermesTU GUI.
	 */
	private void addComponents(){
		int x=10;
		int y=2;
		int dimx=160;
		int dimy=56;
		int stepy=60;
		addMenu(this);
		addGaphIcon(690,y,90,27);
		y=y+20;
		String[] availableVirtualChannel = {"1"};
		addVirtualChannel(x, y, dimx, dimy, availableVirtualChannel, ""+noc.getVirtualChannel(), this);
		y=y+stepy;
		String[] dimension = { "2", "3", "4", "5", "6", "7", "8", "9", "10", "11","12", "13", "14", "15", "16"};
		addDimensions(x, y, dimx, dimy, dimension, ""+noc.getNumRotX(), ""+noc.getNumRotY(), this);
		y=y+stepy;
		String[] availableFlitWidth = { "8", "16", "32", "64" };
		addFlitWidth(x, y, dimx, dimy, availableFlitWidth, ""+noc.getFlitSize(), this);
		y=y+stepy;
		String[] availableDepth = { "4", "8", "16", "32" };
		addBuffer(x, y, dimx, dimy, availableDepth, ""+noc.getBufferDepth());
		y=y+stepy;
		String[] availableAlgorithm = {"CG"};
		addRoutingAlgorithm(x, y, dimx, dimy, availableAlgorithm, noc.getRoutingAlgorithm());
		y=y+stepy;
//		addSCTestBench(x, y, dimx, 51, noc.isSCTB(), this);
		y=y+65;
		addGenerateButton(x, y, dimx, 40, this);
		y+=55;
        addFacinIcon(20,y,150,150);
		addNoCPanel(180, 30, 600, 557, noc.getType());
		
		//Fixed parameters
		getVirtualChannel().setEnabled(false);
		getRoutingAlgorithm().setEnabled(false);
	}

	/**
	 * Update the project with the NoC parameters.
	 */
	private void updateProject(){
		noc.setNumRotX(getDimXSelected());
		noc.setNumRotY(getDimYSelected());
		noc.setFlitSize(Integer.valueOf(getFlitWidthSelected()).intValue());
		noc.setBufferDepth(Integer.valueOf(getBufferDepthSelected()).intValue());
		project.setNoCGenerate(true);
		project.setTrafficGenerate(false);
		//write the project file.
		project.write();
	}

	/**
	 * Generate the NoC with the selected parameters.
	 */
	private void generate(){
		updateProject();
		new NocComponentsCreator().geraNoc(
				project.getPath(),
				getDimXSelected(),getDimYSelected(),
				Integer.valueOf(getFlitWidthSelected()).intValue(),
				Integer.valueOf(getBufferDepthSelected()).intValue()
		);
		super.dispose();
	}
	
	/**
	 * Verify the NoC dimension. <p>
	 * It is not allowed a 2x2 NoC. <p>
	 * When the NoC has at least one dimension greater than 3, 
	 * the flit width must be different to 8. 
	 * @param e The action event to be treated.
	 */
	public void verifyDimension(ActionEvent e){
		if(e.getSource()==getDimX()){
			if(getDimXSelected() == 2){
				getDimY().removeItem("2");
			}
			else if(getDimY().getItemAt(0) != "2"){
				getDimY().insertItemAt("2",0);
			}
		}
		else if(e.getSource()==getDimY()){
			if(getDimYSelected() == 2){
				getDimX().removeItem("2");
			}
			else if(getDimX().getItemAt(0) != "2"){
				getDimX().insertItemAt("2",0);
			}
		}
	
		if ( e.getSource()==getDimX() || e.getSource()==getDimY()){
			if ((getDimXSelected() > 3) || (getDimYSelected() > 3)){
				getFlitWidth().removeItem("8");
			}
			else if ((getDimXSelected() <= 3) && (getDimYSelected() <= 3)){
				if(getFlitWidth().getItemAt(0) != "8")
					getFlitWidth().insertItemAt("8",0);
			}
		}
		getNoCPanel().setNoCDimension(getDimXSelected(),getDimYSelected());
	}	
	
	public void actionPerformed(ActionEvent e){
		if ( e.getSource()==getDimX() || e.getSource()==getDimY() )
			verifyDimension(e);
		else if(e.getSource()==getGenerateButton()){
			if(project.isNoCGenerate()){
				int option = JOptionPane.showConfirmDialog(null,"This option clean throughout the project, removing all files generated by the Traffic Generation and Traffic Evaluation. Do you want to do this?","Question Message", JOptionPane.OK_CANCEL_OPTION);
				if(option == JOptionPane.OK_OPTION){
					project.delete();
					generate();
				}
			}
			else
				generate();
		}
		else if(e.getActionCommand().equalsIgnoreCase("Documentation"))
			Help.show("https://corfu.pucrs.br/redmine/projects/atlas/wiki");
		else if(e.getActionCommand().equalsIgnoreCase("About Jupiter"))
			JOptionPane.showMessageDialog(null, 
					"JUPITER          22.02.2008\nDeveloped by:\n" +
					"          Celso Soccol \n" +
					"          Erico Bastos \n" +
					"          Gerson Scartezzini (gersonscar@gmail.com) \n" +
					"          Tiago Baptista Noronha (tiago.bn@gmail.com)",
					"VERSION 1.1", JOptionPane.INFORMATION_MESSAGE);
	}
}
