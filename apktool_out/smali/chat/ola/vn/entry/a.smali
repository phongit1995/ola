.class public Lchat/ola/vn/entry/a;
.super Ljava/lang/Object;


# instance fields
.field public a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;"
        }
    .end annotation
.end field

.field public b:Ljava/lang/String;

.field public c:I

.field public d:I

.field public e:S


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/entry/a;->a:Ljava/util/List;

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 1

    check-cast p1, Lchat/ola/vn/entry/a;

    iget-object v0, p0, Lchat/ola/vn/entry/a;->b:Ljava/lang/String;

    iget-object p1, p1, Lchat/ola/vn/entry/a;->b:Ljava/lang/String;

    invoke-static {v0, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    return p1
.end method
