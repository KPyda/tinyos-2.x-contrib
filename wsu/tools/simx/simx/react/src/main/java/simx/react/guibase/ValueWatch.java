/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/*
 * ValueWatch.java
 *
 * Created on 8-Oct-2009, 10:56:10 PM
 */

package simx.react.guibase;

import java.util.Enumeration;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.TreeNode;

/**
 *
 * @author yxg
 */
public class ValueWatch extends javax.swing.JPanel {

    /** Creates new form ValueWatch */
    public ValueWatch() {
        initComponents();
    }

    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jScrollPane1 = new javax.swing.JScrollPane();
        jTree1 = new javax.swing.JTree();
        jScrollPane2 = new javax.swing.JScrollPane();
        jTable1 = new javax.swing.JTable();
        Delete = new javax.swing.JButton();
        nodesList = new javax.swing.JTextField();
        jLabel1 = new javax.swing.JLabel();

        jTree1.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                click(evt);
            }
        });
        jTree1.addTreeSelectionListener(new javax.swing.event.TreeSelectionListener() {
            public void valueChanged(javax.swing.event.TreeSelectionEvent evt) {
                ListValueChanged(evt);
            }
        });
        jScrollPane1.setViewportView(jTree1);

        jTable1.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null},
                {null, null, null},
                {null, null, null},
                {null, null, null}
            },
            new String [] {
                "NodeID", "Variable", "Value"
            }
        ) {
            Class[] types = new Class [] {
                java.lang.Integer.class, java.lang.String.class, java.lang.Object.class
            };

            public Class getColumnClass(int columnIndex) {
                return types [columnIndex];
            }
        });
        jScrollPane2.setViewportView(jTable1);

        Delete.setText("DELETE");
        Delete.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                DeleteActionPerformed(evt);
            }
        });

        nodesList.setText("1,2,3,4,5,6,7,8,9,10");
        nodesList.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                nodesListActionPerformed(evt);
            }
        });

        jLabel1.setText("Nodes:");

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(23, 23, 23)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 188, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(jScrollPane2, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.PREFERRED_SIZE, 452, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                        .addGroup(layout.createSequentialGroup()
                            .addComponent(jLabel1)
                            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                            .addComponent(nodesList, javax.swing.GroupLayout.PREFERRED_SIZE, 387, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addComponent(Delete, javax.swing.GroupLayout.PREFERRED_SIZE, 134, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(263, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 314, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(nodesList, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel1))
                        .addGap(12, 12, 12)
                        .addComponent(Delete))
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 439, Short.MAX_VALUE))
                .addContainerGap())
        );
    }// </editor-fold>//GEN-END:initComponents
/*
    private void DeleteActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_DeleteActionPerformed
 */
    public void DeleteActionPerformed(java.awt.event.ActionEvent evt) {
 // TODO add your handling code here:
    }//GEN-LAST:event_DeleteActionPerformed

    private void click(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_click
        // TODO add your handling code here:
        
    }//GEN-LAST:event_click
/*
    private void ListValueChanged(javax.swing.event.TreeSelectionEvent evt) {//GEN-FIRST:event_ListValueChanged
 */
     protected void ListValueChanged(javax.swing.event.TreeSelectionEvent evt) {
 // TODO add your handling code here:
       // System.out.println("Current Selection: " + jTree1.getLastSelectedPathComponent().toString());

        
        //System.out.println(new DefaultMutableTreeNode(jTree1.getLastSelectedPathComponent()).getPath().toString() );
        DefaultMutableTreeNode node=(DefaultMutableTreeNode)(jTree1.getLastSelectedPathComponent());
        String name=""+node;
        while(node.getParent()!=null){
        //if(!name.equalsIgnoreCase(""))
         if(node.getParent().toString().equalsIgnoreCase("Root"))
            name=node.getParent()+"$"+name;
        node=(DefaultMutableTreeNode)node.getParent();
        }
         //System.out.println(name);

         



    }//GEN-LAST:event_ListValueChanged

     private void nodesListActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_nodesListActionPerformed
         // TODO add your handling code here:
     }//GEN-LAST:event_nodesListActionPerformed


    // Variables declaration - do not modify//GEN-BEGIN:variables
    public javax.swing.JButton Delete;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    public javax.swing.JTable jTable1;
    public javax.swing.JTree jTree1;
    protected javax.swing.JTextField nodesList;
    // End of variables declaration//GEN-END:variables
   public DefaultMutableTreeNode isexist(DefaultMutableTreeNode root, DefaultMutableTreeNode dmt){
    Enumeration<DefaultMutableTreeNode> e=root.depthFirstEnumeration();
     while(e.hasMoreElements()){
            //System.out.println(e.nextElement());
         DefaultMutableTreeNode tmp = (DefaultMutableTreeNode)e.nextElement();
            if(dmt.toString().equalsIgnoreCase(tmp.toString()))
                return tmp;
     }
    return null;

   }
}
