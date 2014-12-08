package jya.ui;

import org.eclipse.swt.*;
import org.eclipse.swt.widgets.*;

public class Entry {
	public static void main(String[] args) {
		try {
			Display display = new Display();
		    Shell shell = new Shell(display);
		    Label label = new Label(shell, SWT.NONE);
		    label.setText("Hello World");
		    label.pack();
		    shell.pack();
		    shell.open();
		    while (!shell.isDisposed()) 
		    {
		       if (!display.readAndDispatch()) display.sleep();
		    }
		    display.dispose();			
		}
		catch (Exception ex) {
			System.err.println("SyS-FAULT: " + ex.getLocalizedMessage());
			ex.printStackTrace(System.err);
		}
	}
}
