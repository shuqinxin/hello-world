package{
	import flash.display.GradientType;
	import flash.display.GraphicsPathCommand;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;

	public class LeafStrip extends Sprite{
		private var size:Number;
		private var limitW:Number;
		private var limitH:Number;
		private var color:uint;
		private var leafs:Array;
		private var rZ:Number=0;
		private var steprZ:Number=0.5;
		
		public function LeafStrip(color:uint,limitW:Number,limitH:Number){
			this.limitW=limitW*1.1;
			this.limitH=limitH*1.1;
			this.color=color;
			this.size=limitW/16;
			init();
			//addEventListener(Event.ENTER_FRAME,onEnterFrame);
		
		}
		
		private function onEnterFrame(event:Event):void{
			rZ+=steprZ;
			for (var i:int=0; i<5; i++){
				leafs[i].rotation=rZ;
			}
				this.rotationY=rZ;
			if (rZ==5||rZ==-5){
				steprZ=-steprZ;
			}
		}
		
		private function init():void {
			leafs=new Array();
			graphics.lineStyle(1,0xffffff,0);
			graphics.drawRect(0,0,limitW,limitH);
			
			//stem
			var commands0:Vector.<int> = new Vector.<int>();
			var data0:Vector.<Number> = new Vector.<Number>();
			
			data0.push(0,0);
			
			data0.push(-limitH/10,limitH/24*5);
			data0.push(0,limitH/12*5);
			
			data0.push(limitH/10,limitH/24*15);
			data0.push(0,limitH/6*5);
			
			commands0.push(GraphicsPathCommand.MOVE_TO);
			commands0.push(GraphicsPathCommand.CURVE_TO);
			commands0.push(GraphicsPathCommand.CURVE_TO);
			
			
			//leaf
			var commands1:Vector.<int> = new Vector.<int>();
			var data1:Vector.<Number> = new Vector.<Number>();
			
			data1.push(0,0);
			
			data1.push(size/2,-size/3);
			data1.push(size,0);
			
			data1.push(size/2,size/3);
			data1.push(0,0);
			
			commands1.push(GraphicsPathCommand.MOVE_TO);
			commands1.push(GraphicsPathCommand.CURVE_TO);
			commands1.push(GraphicsPathCommand.CURVE_TO);
			
			var commands2:Vector.<int> = new Vector.<int>();
			var data2:Vector.<Number> = new Vector.<Number>();
			
			data2.push(0,0);
			data2.push(size,0);
			
			data2.push(size*0.325,-size/10);
			data2.push(size*0.25,0);
			data2.push(size*0.325,size/10);
			
			data2.push(size*0.625,-size/10);
			data2.push(size*0.5,0);
			data2.push(size*0.625,size/10);
			
			data2.push(size*0.85,-size/20);
			data2.push(size*0.75,0);
			data2.push(size*0.85,size/20);
			
			commands2.push(GraphicsPathCommand.MOVE_TO);
			commands2.push(GraphicsPathCommand.LINE_TO);
			commands2.push(GraphicsPathCommand.MOVE_TO);
			commands2.push(GraphicsPathCommand.LINE_TO);
			commands2.push(GraphicsPathCommand.LINE_TO);
			
			commands2.push(GraphicsPathCommand.MOVE_TO);
			commands2.push(GraphicsPathCommand.LINE_TO);
			commands2.push(GraphicsPathCommand.LINE_TO);
			
			commands2.push(GraphicsPathCommand.MOVE_TO);
			commands2.push(GraphicsPathCommand.LINE_TO);
			commands2.push(GraphicsPathCommand.LINE_TO);
			
			
				var stem:Sprite=new Sprite();
				stem.graphics.lineStyle(6,0xfa7370);
				stem.graphics.lineGradientStyle(GradientType.RADIAL,[0xfa706e,0xfec29d,0x0d1733],[1,1,1],[0,32,255]);	
				stem.graphics.drawPath(commands0,data0);
				addChild(stem);
				
				for (var j:int=0; j<5; j++){
					var leaf:Sprite=new Sprite();
					var gradientLeafMatrix:Matrix = new Matrix(); 
					gradientLeafMatrix.createGradientBox(size/2, size/3, 0, 0, 0); 
					leaf.graphics.lineStyle(1,0xa869b8);
					leaf.graphics.beginGradientFill(GradientType.LINEAR,[0xfa706e,0xfec29d],[1,0.9],[0,255],gradientLeafMatrix);
					leaf.graphics.drawPath(commands1,data1);
					leaf.graphics.endFill();
					leaf.graphics.drawPath(commands2,data2);
					leaf.x=(j-2)%2*limitH/10/(j%2+1);
					leaf.y=j*limitH/24*5;
					leaf.scaleX=1-j%2*2;
					addChild(leaf);
					leafs.push(leaf);
				}
			}
		
		public function openPlay():void{
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		public function endPlay():void{
			removeEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
			
	
	}
}