package
{
	public class GraphModel
	{
		private static const MAXWEIGHT : int = 1000;   //最大权值
		private var m_arrPoint : Array = [];    //结点
		private var m_arrEdge : Array = [];    //边
		private var m_iEdgeNum : int = 0;      //边数
		
		public function GraphModel(sz : int)
		{
			for(var i : int = 0; i < sz; i ++)
			{
				m_arrEdge.push( [] );
				for(var j : int = 0; j < sz; j ++)
				{
					var karray : Array = [];
					if(i == j)
					{
						karray.push( 0 );
					}
					else
					{
						karray.push( MAXWEIGHT );
					}
					m_arrEdge[i].push( karray );
				}
			}
			this.m_iEdgeNum = 0;
		}
		
		/**
		 * 图是否为空 
		 * @return 
		 * 
		 */		
		public function IsGraphEmpty():Boolean
		{
			return true;
		}
		
		/**
		 * 取总结点数 
		 * @return 
		 * 
		 */		
		public function getTotalPoint():int
		{
			return this.m_arrPoint.length;
		}
		
		/**
		 * 取总边数 
		 * @return 
		 * 
		 */		
		public function getEdgeNum():int
		{
			return this.m_iEdgeNum;
		}
		
		/**
		 * 取结点point的值 
		 * @param point
		 * @return 
		 * 
		 */		
		public function getPoint(point : int):int
		{
			if(point < 0 || point > this.m_arrPoint.length)
			{
				;//trace("越界");
				return -1;
			}
			return this.m_arrPoint[point];
		}
		
		/**
		 * 取边（point1,point2）的权 
		 * @param point1
		 * @param point2
		 * @return 
		 * 
		 */		
		public function getWeight(point1 : int, point2 : int):Number
		{
			var kilength : int = this.m_arrPoint.length;
			if(point1 < 0 || point1 > kilength || point2 < 0 || point2 > kilength)
			{
				;//trace("越界");
				return 0;
			}
			return this.m_arrEdge[point1][point2];
		}
		
		/**
		 * 插入结点 
		 * @param point
		 * 
		 */		
		public function InsertPoint(point : int):void
		{
			this.m_arrPoint.push(point);
		}
		
		/**
		 * 插入边(point1,point2)的权 
		 * @param point1
		 * @param point2
		 * @param weight
		 * 
		 */		
		public function InsertEdge(point1 : int, point2 : int, weight : Number):void
		{
			var kilength : int = this.m_arrPoint.length;
			if(point1 < 0 || point1 > kilength || point2 < 0 || point2 > kilength)
			{
				;//trace("越界");
				return;
			}
			this.m_arrEdge[point1][point2] = weight;   //插入权为weight的边
			this.m_iEdgeNum ++;                       //边个数+1
		}
		
		/**
		 * 删除结点point和与结点point相关的所有边
		 * 
		 */		
		public function DeletePoint(point : int):void
		{
			var kilength : int = this.m_arrPoint.length;
			var i : int = 0;
			var j : int = 0;
			//计算删除后的边数
			for(i = 0; i < kilength; i ++)
			{
				for(j = 0; j < kilength; j ++)
				{
					if( (i == point || j == point) && this.m_arrEdge[i][j] > 0 && this.m_arrEdge[i][j] < MAXWEIGHT )
					{
						this.m_iEdgeNum --;
					}
				}				
			}
			
			//删除第point行
			for(i = 0; i < kilength; i ++)
			{
				for(j = 0; j < kilength; j ++)
				{
					this.m_arrEdge[i][j] = this.m_arrEdge[i + 1][j];
				}				
			}
			
			//删除第point列
			for(i = 0; i < kilength; i ++)
			{
				for(j = 0; j < kilength; j ++)
				{
					this.m_arrEdge[i][j] = this.m_arrEdge[i][j + 1];
				}				
			}
			
			//删除结点point
			this.m_arrPoint.splice(point, 1);
		}
		
		/**
		 * 删除边(point1,point2)
		 * @param point1
		 * @param point2
		 * 
		 */		
		public function DeleteEdge(point1 : int, point2 : int):void
		{
			var kilength : int = this.m_arrPoint.length;
			if(point1 < 0 || point1 > kilength || point2 < 0 || point2 > kilength || point1 == point2)
			{
				//trace("越界");
			}
			this.m_arrEdge[point1][point2] = MAXWEIGHT;     //把该边的权值置为无穷
			this.m_iEdgeNum --;
		}
		
		/**
		 * 取结点point的第一条邻接边，取到返回该邻接边的邻接结点下标，否则返回-1 
		 * @param point
		 * 
		 */		
		public function getFirstNeighhbor(point : int):Number
		{
			var kilength : int = this.m_arrPoint.length;
			if(point < 0 || point > kilength)
			{
				//trace("越界");
			}
			for(var col : int = 0; col <= kilength; col ++)
			{
				//若存在，则返回该邻接边的邻接结点下标
				if(this.m_arrEdge[point][col] > 0 && this.m_arrEdge[point][col] < MAXWEIGHT)
				{
					return col;
				}
			}
			return -1;
		}
		
		/**
		 * 取结点point1的邻接边(point1,point2),
		 * 若下一条的邻接边存在，则返回该邻接边的邻接节点下标，否则返回-1
		 * @param point1
		 * @param point2
		 * 
		 */		
		public function getNextNeighbor(point1 : int, point2 : int):Number
		{
			var kilength : int = this.m_arrPoint.length;
			if(point1 < 0 || point1 > kilength || point2 < 0 || point2 > kilength)
			{
				//trace("越界");
			}
			//使col = point2 + 1,因此寻找的是结点point1的(point1, point2)邻接边的下一条邻接边
			for(var col : int = (point2 + 1); col <= kilength; col ++)
			{
				if(this.m_arrEdge[point1][col] > 0 && this.m_arrEdge[point1][col] < MAXWEIGHT)
				{
					return col;
				}
			}
			return -1;
		}
	}
}