unit GeometryBaseClass;

interface

    uses
        system.SysUtils, system.Math,
        GeometryTypes;

    type
        TGeom = class
            public
                constructor create();
                destructor destroy(); override;
                function boundingBox() : TGeomBox; virtual; abstract;
        end;

implementation

    constructor TGeom.create();
        begin
            inherited create();
        end;

    destructor TGeom.destroy();
        begin
            inherited Destroy();
        end;

end.
