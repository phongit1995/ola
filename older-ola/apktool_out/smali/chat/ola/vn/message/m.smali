.class public Lchat/ola/vn/message/m;
.super Lchat/ola/vn/message/u;


# instance fields
.field protected a:I

.field protected b:Lchat/ola/vn/o/d;


# direct methods
.method public constructor <init>()V
    .locals 1

    const-string v0, "osimi.chat.ola.vn"

    invoke-direct {p0, v0}, Lchat/ola/vn/message/u;-><init>(Ljava/lang/String;)V

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/message/m;->a:I

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/message/m;->b:Lchat/ola/vn/o/d;

    new-instance v0, Lchat/ola/vn/o/d;

    invoke-direct {v0}, Lchat/ola/vn/o/d;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/message/m;->b:Lchat/ola/vn/o/d;

    return-void
.end method


# virtual methods
.method public Y()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f00f4

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public Z()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f046e

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public a(Lchat/ola/vn/message/f;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/message/u;->a(Lchat/ola/vn/message/f;)V

    check-cast p1, Lchat/ola/vn/message/m;

    iget-object p1, p1, Lchat/ola/vn/message/m;->b:Lchat/ola/vn/o/d;

    iput-object p1, p0, Lchat/ola/vn/message/m;->b:Lchat/ola/vn/o/d;

    return-void
.end method

.method public a(Landroid/content/Context;)Z
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/m;->b:Lchat/ola/vn/o/d;

    invoke-virtual {v0, p1}, Lchat/ola/vn/o/d;->b(Landroid/content/Context;)Z

    const/4 p1, 0x0

    return p1
.end method

.method public aa()Ljava/lang/String;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public ab()Ljava/lang/String;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public ac()I
    .locals 1

    const v0, 0x7f08079a

    return v0
.end method

.method public b(Lchat/ola/vn/message/f;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/message/u;->b(Lchat/ola/vn/message/f;)V

    check-cast p1, Lchat/ola/vn/message/m;

    iget-object p1, p1, Lchat/ola/vn/message/m;->b:Lchat/ola/vn/o/d;

    iput-object p1, p0, Lchat/ola/vn/message/m;->b:Lchat/ola/vn/o/d;

    return-void
.end method
