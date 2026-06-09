.class public Lchat/ola/vn/v/b;
.super Ljava/lang/Object;


# instance fields
.field a:Ljava/lang/String;

.field b:I

.field c:I

.field d:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method a()V
    .locals 2

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/v/b;->a:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/v/b;->d:Ljava/util/List;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/v/b;->d:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    iput-object v0, p0, Lchat/ola/vn/v/b;->d:Ljava/util/List;

    :cond_0
    return-void
.end method

.method public a(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/v/b;->b:I

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/v/b;->a:Ljava/lang/String;

    return-void
.end method

.method public b(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/v/b;->c:I

    return-void
.end method
