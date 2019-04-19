package test;
import java.util.*;
import java.io.*;

public class PrintMips {
	public static Scanner inFile;
	public static PrintWriter outFile;
	public static String fileStuff;

	public static void main(String[] args) throws IOException {
		putErIn();
		File fileName = new File("moves.rtf"); //put name of instruction file here
		//fileName.createNewFile();
		System.out.println(fileName.getPath());
		System.out.println(fileName.exists());

		inFile = new Scanner(fileName);
		System.out.println("made Scanner");

		File mipsMoves = new File("mipsMoveSeqs.txt");
		mipsMoves.createNewFile();
		System.out.println(mipsMoves.getPath());
		System.out.println(mipsMoves.exists());
		outFile = new PrintWriter(mipsMoves);
		System.out.println("made printwrite");

		while(inFile.hasNextLine()) {
			String token = inFile.nextLine();
			if(token.contains("#")) {
				translateMoves(token);
				outFile.println(); //register stuff
			} else {
				outFile.println(token);
				outFile.println(); //register stuff
			}
		}
		inFile.close();
		outFile.close();
	}

	public static void translateMoves(String token) {
		for(int i = 0; i < token.length(); i++) {
			if(token.charAt(i) == 'L') {
				if(i+1 < token.length() && token.charAt(i+1) == '\'') {
					outFile.println("\tjal Lc");
					i++;
				} else {
					outFile.println("\tjal L");
				}
			} else if(token.charAt(i) == 'R') {
				if(i+1 < token.length() && token.charAt(i+1) == '\'') {
					outFile.println("\tjal Rc");
					i++;
				} else {
					outFile.println("\tjal R");
				}
			} else if(token.charAt(i) == 'F') {
				if(i+1 < token.length() && token.charAt(i+1) == '\'') {
					outFile.println("\tjal Fc");
					i++;
				} else {
					outFile.println("\tjal F");
				}
			} else if(token.charAt(i) == 'B') {
				if(i+1 < token.length() && token.charAt(i+1) == '\'') {
					outFile.println("\tjal Bc");
					i++;
				} else {
					outFile.println("\tjal B");
				}
			} else if(token.charAt(i) == 'U') {
				if(i+1 < token.length() && token.charAt(i+1) == '\'') {
					outFile.println("\tjal Uc");
					i++;
				} else {
					outFile.println("\tjal U");
				}
			} else if(token.charAt(i) == 'D') {
				if(i+1 < token.length() && token.charAt(i+1) == '\'') {
					outFile.println("\tjal Dc");
					i++;
				} else {
					outFile.println("\tjal D");
				}
			}
		}
	}
	
	public static void putErIn() throws FileNotFoundException {
		fileStuff = "FrontTopLeftFront2FrontTopRightUp:\n" + 
				"	# RF'R'DF'\n" + 
				"FrontTopLeftUp2FrontTopRightUp:\n" + 
				"	# F'DFDF'\n" + 
				"FrontTopLeftLeft2FrontTopRightUp:\n" + 
				"	# F \n" + 
				"\n" + 
				"FrontTopRightFront2FrontTopRightUp:\n" + 
				"	# L'FLBRB'\n" + 
				"FrontTopRightRight2FrontTopRightUp:\n" + 
				"	# BR'B'L'F'L\n" + 
				"\n" + 
				"FrontBottomLeftFront2FrontTopRightUp:\n" + 
				"	# DL'F'L\n" + 
				"FrontBottomLeftDown2FrontTopRightUp:\n" + 
				"	# L'FFLBRB'\n" + 
				"FrontBottomLeftLeft2FrontTopRightUp:\n" + 
				"	# DBRB'\n" + 
				"\n" + 
				"FrontBottomRightFront2FrontTopRightUp:\n" + 
				"	# BRB'\n" + 
				"FrontBottomRightDown2FrontTopRightUp:\n" + 
				"	# L'F'LBR'B'L'F'L\n" + 
				"FrontBottomRightRight2FrontTopRightUp:\n" + 
				"	# L'F'L\n" + 
				"\n" + 
				"BackTopLeftBack2FrontTopRightUp:\n" + 
				"	# R'BRD'D'BRB'\n" + 
				"BackTopLeftUp2FrontTopRightUp:\n" + 
				"	# FL'F'D'D'BRB'\n" + 
				"BackTopLeftLeft2FrontTopRightUp:\n" + 
				"	# FL'F'DDL'F'L\n" + 
				"\n" + 
				"BackTopRightBack2FrontTopRightUp: \n" + 
				"	# R' 	\n" + 
				"BackTopRightUp2FrontTopRightUp:\n" + 
				"	# LB'L'D'R\n" + 
				"BackTopRightRight2FrontTopRightUp:\n" + 
				"	# F'RFD'R\n" + 
				"\n" + 
				"BackBottomLeftBack2FrontTopRightUp:\n" + 
				"	# D'D'BRB'\n" + 
				"BackBottomLeftDown2FrontTopRightUp:\n" + 
				"	# DDL'F'LBR'B'L'F'L\n" + 
				"BackBottomLeftLeft2FrontTopRightUp:\n" + 
				"	# DDL'F'L\n" + 
				"\n" + 
				"BackBottomRightBack2FrontTopRightUp:\n" + 
				"	# D'L'F'L\n" + 
				"BackBottomRightDown2FrontTopRightUp:\n" + 
				"	# D'L'F'LBR'B'L'F'L\n" + 
				"BackBottomRightRight2FrontTopRightUp:\n" + 
				"	# D'BRB'\n" + 
				"\n" + 
				"\n" + 
				"\n" + 
				"FrontTopLeftFront2FrontTopLeftUp:\n" + 
				"	# RF'R'B'L'B\n" + 
				"FrontTopLeftLeft2FrontTopLeftUp:\n" + 
				"	# B'LBRFR'\n" + 
				"\n" + 
				"FrontTopRightFront2FrontTopLeftUp:\n" + 
				"	# FD'RFR'\n" + 
				"FrontTopRightUp2FrontTopLeftUp:\n" + 
				"	# R'D'RF\n" + 
				"FrontTopRightRight2FrontTopLeftUp:\n" + 
				"	# BR'B'D'B'L'B\n" + 
				"\n" + 
				"FrontBottomLeftFront2FrontTopLeftUp:\n" + 
				"	# B'L'B\n" + 
				"FrontBottomLeftDown2FrontTopLeftUp:\n" + 
				"	# DDB'L'BRFR'\n" + 
				"FrontBottomLeftLeft2FrontTopLeftUp:\n" + 
				"	# RFR'\n" + 
				"\n" + 
				"FrontBottomRightFront2FrontTopLeftUp:\n" + 
				"	# D'RFR'\n" + 
				"FrontBottomRightDown2FrontTopLeftUp:\n" + 
				"	# DDL'FLF'D'B'L'B\n" + 
				"FrontBottomRightRight2FrontTopLeftUp:\n" + 
				"	# D'B'L'B\n" + 
				"\n" + 
				"BackTopLeftBack2FrontTopLeftUp:\n" + 
				"	# L\n" + 
				"BackTopLeftUp2FrontTopLeftUp:\n" + 
				"	# R'BRDL'\n" + 
				"BackTopLeftLeft2FrontTopLeftUp:\n" + 
				"	# FL'F'DL'\n" + 
				"\n" + 
				"BackTopRightBack2FrontTopLeftUp:\n" + 
				"	# LB'L'DDB'L'B\n" + 
				"BackTopRightUp2FrontTopLeftUp:\n" + 
				"	# B'D'D'BRFR'\n" + 
				"BackTopRightRight2FrontTopLeftUp:\n" + 
				"	# F'RFD'D'RFR'\n" + 
				"\n" + 
				"BackBottomLeftBack2FrontTopLeftUp:\n" + 
				"	# DRFR'\n" + 
				"BackBottomLeftDown2FrontTopLeftUp:\n" + 
				"	# DRFR'B'LBRFR'\n" + 
				"BackBottomLeftLeft2FrontTopLeftUp:\n" + 
				"	# DL'\n" + 
				"\n" + 
				"BackBottomRightBack2FrontTopLeftUp:\n" + 
				"	# DDB'L'B\n" + 
				"BackBottomRightDown2FrontTopLeftUp:\n" + 
				"	# DFL'F'LD'RFR'\n" + 
				"BackBottomRightRight2FrontTopLeftUp:\n" + 
				"	# DDRFR'\n" + 
				"\n" + 
				"\n" + 
				"\n" + 
				"FrontTopLeftFront2BackTopLeftUp:\n" + 
				"	# L'\n" + 
				"FrontTopLeftUp2BackTopLeftUp:\n" + 
				"	# RF'R'D'L\n" + 
				"FrontTopLeftLeft2BackTopLeftUp:\n" + 
				"	# B'LBD'L\n" + 
				"\n" + 
				"FrontTopRightFront2BackTopLeftUp:\n" + 
				"	# L'FLDDFLF'\n" + 
				"FrontTopRightUp2BackTopLeftUp:\n" + 
				"	# L'F'LD'FLF'\n" + 
				"FrontTopRightRight2BackTopLeftUp:\n" + 
				"	# BR'B'DDR'B'R\n" + 
				"\n" + 
				"FrontBottomLeftFront2BackTopLeftUp:\n" + 
				"	# D'R'B'R\n" + 
				"FrontBottomLeftDown2BackTopLeftUp:\n" + 
				"	# D'L'D'LFL'F'R'B'R\n" + 
				"FrontBottomLeftLeft2BackTopLeftUp:\n" + 
				"	# D'FLF'\n" + 
				"\n" + 
				"FrontBottomRightFront2BackTopLeftUp:\n" + 
				"	# D'D'FLF'\n" + 
				"FrontBottomRightDown2BackTopLeftUp:\n" + 
				"	# DDL'DLDDR'B'R\n" + 
				"FrontBottomRightRight2BackTopLeftUp:\n" + 
				"	# DDR'B'R\n" + 
				"\n" + 
				"BackTopLeftBack2BackTopLeftUp:\n" + 
				"	# R'BRFLF'\n" + 
				"\n" + 
				"BackTopLeftLeft2BackTopLeftUp:\n" + 
				"	# FL'F'R'B'R\n" + 
				"\n" + 
				"BackTopRightBack2BackTopLeftUp:\n" + 
				"	# LB'L'DB'\n" + 
				"BackTopRightUp2BackTopLeftUp:\n" + 
				"	# F'RF \n" + 
				"BackTopRightRight2BackTopLeftUp:\n" + 
				"	# B\n" + 
				"\n" + 
				"BackBottomLeftBack2BackTopLeftUp:\n" + 
				"	# FLF'\n" + 
				"BackBottomLeftDown2BackTopLeftUp:\n" + 
				"	# R'B'RFL'F'R'B'R\n" + 
				"BackBottomLeftLeft2BackTopLeftUp:\n" + 
				"	# R'B'R";
		File newFile = new File("moves.rtf");
		PrintWriter printyBoi = new PrintWriter(newFile);
		printyBoi.print(fileStuff);
		printyBoi.close();
	}

}
