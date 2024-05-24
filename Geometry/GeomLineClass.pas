unit GeomLineClass;

interface

    uses
        system.sysUtils, Math,
        GeometryTypes, GeomVectorClass;

    type
        TGeomLine = class
            private
                const
                    //line vector index constants
                        x : integer = 0;
                        y : integer = 1;
                        z : integer = 2;
                var
                    startPoint, endPoint    : TGeomPoint;
                    lineVector              : TGeomSpaceVector;
                //helper methods
                    //calculat line projections on 3 axes
                        procedure calculateAxisProjections();
                    //assign points
                        procedure assignPoints(startPointIn, endPointIn : TGeomPoint);
                        procedure updatePoints();
            protected
                //
            public
                //constructor
                    constructor create(); overload;
                    constructor create(startPointIn, endPointIn : TGeomPoint); overload;
                //destructor
                    destructor destroy(); override;
                //accessors
                    function getStartPoint() : TGeomPoint;
                    function getEndPoint() : TGeomPoint;
                //modifiers
                    procedure setStartPoint(startPointIn : TGeomPoint);
                    procedure setEndPoint(endPointIn : TGeomPoint);
                //calculate line length
                    function length() : double;
                //bounding box
                    function boundingBox() : TGeomBox;
        end;

implementation

    //private
        //helper methods
            //calculat line projections on 3 axes
                //x-axis (x-component)
                    procedure TGeomLine.calculateAxisProjections();
                        begin
                            lineVector[x] := endPoint.x - startPoint.x;
                            lineVector[y] := endPoint.y - startPoint.y;
                            lineVector[z] := endPoint.z - startPoint.z;
                        end;

            //assign points
                procedure TGeomLine.assignPoints(startPointIn, endPointIn : TGeomPoint);
                    begin
                        startPoint  := startPointIn;
                        endPoint    := endPointIn;

                        calculateAxisProjections();
                    end;

                procedure TGeomLine.updatePoints();
                    begin
                        assignPoints(startPoint, endPoint);
                    end;

    //public
        //constructor
            constructor TGeomLine.create();
                begin
                    inherited create();

                    lineVector := TGeomSpaceVector.create();

                    lineVector.setDimensions(3);
                end;

            constructor TGeomLine.create(startPointIn, endPointIn : TGeomPoint);
                begin
                    create();

                    assignPoints(startPointIn, endPointIn);
                end;

        //desturctor
            destructor TGeomLine.destroy();
                begin
                    inherited destroy();
                end;

        //calculate line length
            function TGeomLine.length() : double;
                begin
                    result := lineVector.normalise();
                end;

        //accessors
            function TGeomLine.getStartPoint() : TGeomPoint;
                begin
                    result := startPoint;
                end;

            function TGeomLine.getEndPoint() : TGeomPoint;
                begin
                    result := endPoint;
                end;

        //modifiers
            procedure TGeomLine.setStartPoint(startPointIn : TGeomPoint);
                begin
                    startPoint := startPointIn;

                    updatePoints();
                end;

            procedure TGeomLine.setEndPoint(endPointIn : TGeomPoint);
                begin
                    endPoint := endPointIn;

                    updatePoints();
                end;

        //bounding box
            function TGeomLine.boundingBox() : TGeomBox;
                var
                    boxOut : TGeomBox;
                begin
                    //min point
                        boxOut.minPoint.x := min(startPoint.x, endPoint.x);
                        boxOut.minPoint.y := min(startPoint.y, endPoint.y);
                        boxOut.minPoint.z := min(startPoint.z, endPoint.z);

                    //max point
                        boxOut.maxPoint.x := max(startPoint.x, endPoint.x);
                        boxOut.maxPoint.y := max(startPoint.y, endPoint.y);
                        boxOut.maxPoint.z := max(startPoint.z, endPoint.z);
                end;

end.
