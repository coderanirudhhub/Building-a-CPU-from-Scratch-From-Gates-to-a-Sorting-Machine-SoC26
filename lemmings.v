//it contains 2 states
//each state represents their corresponding walking directions(like LEFT represents walk_lefft = 1)
module lemmings_1(
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); 
    reg state, next_state;
   parameter LEFT=0 ,RIGHT=1;
    always @(*) begin
        case(state)
            LEFT: begin
                if (bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            RIGHT: begin
                if (bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
        endcase
    end
    always @(posedge clk, posedge areset) begin
        if(areset)
            state <= LEFT;
        else
            state <= next_state;
    end

            assign walk_left=(state==LEFT);
            assign walk_right=(state==RIGHT);

endmodule

//there are 4 states
// LEFT & RIGHT  tellls in which direction they are walking,
//FALL_LEFT & FALL_RIGHT  tells whether they are in air and while walking in whhich direction.
module lemmings_2(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah); 

    parameter LEFT=0, RIGHT=1, FALL_LEFT=2, FALL_RIGHT=3;
    reg [1:0] state, next_state;
    always @(*) begin
        case(state)
            LEFT: next_state = ground ?(bump_left  ? RIGHT : LEFT) : FALL_LEFT ;
            RIGHT: next_state = ground ?(bump_right ? LEFT  : RIGHT) : FALL_RIGHT ;
            FALL_LEFT: next_state = !ground ? FALL_LEFT  : LEFT;
            FALL_RIGHT: next_state = !ground ? FALL_RIGHT : RIGHT;
            default:    next_state = LEFT;
        endcase
    end
    always @(posedge clk or posedge areset) begin
        if (areset) 
           state <= LEFT;
        else        
            state <= next_state;
    end
    assign walk_left= (state == LEFT);
    assign walk_right=(state == RIGHT);
    assign aaah= (state == FALL_LEFT || state == FALL_RIGHT);
endmodule


//3 states
//4 states same like lemmings_2 and the other two states DIG_L and DIG_R are for representing digging while going in the left side and right side respectively....
module lemmings_3(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    parameter LEFT=0, RIGHT=1, FALL_LEFT=2, FALL_RIGHT=3, DIG_LEFT=4, DIG_RIGHT=5;
    reg [2:0] state, next_state;
    always @(*) begin
        case(state)
            LEFT: next_state = ground ?(dig ? DIG_LEFT  : (bump_left  ? RIGHT : LEFT))  : FALL_LEFT;
            RIGHT: next_state =ground ?(dig ? DIG_RIGHT : (bump_right ? LEFT  : RIGHT)) : FALL_RIGHT ;
            DIG_LEFT: next_state =ground ? DIG_LEFT : FALL_LEFT;
            DIG_RIGHT: next_state =ground ?DIG_RIGHT : FALL_RIGHT;
            FALL_LEFT: next_state =ground ?LEFT : FALL_LEFT;
            FALL_RIGHT: next_state =ground ? RIGHT : FALL_RIGHT;
            default: next_state = LEFT;
        endcase
    end
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= LEFT;
        else        
            state <= next_state;
    end
    assign walk_left= (state == LEFT);
    assign walk_right= (state == RIGHT);
    assign aaah= (state == FALL_LEFT || state == FALL_RIGHT);
    assign digging= (state == DIG_LEFT || state == DIG_RIGHT);

endmodule

//7 statees
//6 states are same like lemmings_3 and the 7th state is SPLAT which tells that it ceases everything after undergoing more than 20 clk cycles(death) and and on reaching grnd
module lemmings_4(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);
    parameter LEFT = 0, RIGHT = 1, FALL_LEFT = 2, FALL_RIGHT = 3, DIG_LEFT = 4, DIG_RIGHT = 5, SPLAT = 6;
    reg [2:0] state, next_state;
    reg [4:0] fall_count;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            fall_count <= 0;
        end 
        else begin
            if (state == FALL_LEFT || state == FALL_RIGHT) begin
                if (fall_count < 32-1)
                  fall_count <= fall_count + 1;
            end 
            else begin
                fall_count <= 0;
            end
        end
    end
    always @(*) begin
        case (state)
            LEFT: next_state = !ground ? FALL_LEFT : (dig ? DIG_LEFT  : (bump_left  ? RIGHT : LEFT));
            RIGHT: next_state = !ground ? FALL_RIGHT : (dig ? DIG_RIGHT : (bump_right ? LEFT  : RIGHT));
            DIG_LEFT: next_state = !ground ? FALL_LEFT : DIG_LEFT;
            DIG_RIGHT: next_state = !ground ? FALL_RIGHT : DIG_RIGHT;
            FALL_LEFT: next_state = !ground ? FALL_LEFT : (fall_count >= 20 ? SPLAT : LEFT);
            FALL_RIGHT: next_state = !ground ? FALL_RIGHT: (fall_count >= 20 ? SPLAT : RIGHT);
            SPLAT: next_state = SPLAT;
            default: next_state = LEFT;
        endcase
    end
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= LEFT;
        else        
            state <= next_state;
    end
    assign walk_left  = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL_LEFT || state == FALL_RIGHT);
    assign digging = (state == DIG_LEFT  || state == DIG_RIGHT);
endmodule
