iOS GraphKit has Line Graph, Bar Graph and Pie chart plotting classes. It is dynamic to number of data and range of data.
The Same data source can be passed to different graphs and get differnt representation for same data source. It has Gradient color representation based on the value ranges, and Basic animation of drawing graph. Different color representation for Pie chart.

Using Graphs
Use the "LineGraph", "BarGraph" which are subclass of UIView. By saving the data in GraphData class, and with GraphScale which is very important in the journey of creating Graphs.

Creating Graph Scale
    
        x_unit -> Unit spacing on X-Axis
         y_unit -> Unit spacing on Y-Axis
         min_x -> Minimum value of X data.
         max_x -> Maximum value of X data.
         min_y -> Minimum value of Y data.
         max_y -> Maximum value of Y data.

Other parameters for scaling purpose


        TOTAL_X_DIST -> It is the total distace of X-Axis on the UIView you wish to have.
        TOTAL_Y_DIST -> It is the total distace of Y-Axis on the UIView you wish to have.
        STARTING_X -> It is the starting point of X Axis (Origin).
        ENDING_X -> Ending point of X-Axis on the screen. 
        STARTING_Y -> It is the starting point of Y Axis (Origin).
        ENDING_Y -> Ending point of Y-Axis on the screen.



