.class public Lchat/ola/vn/message/h;
.super Lchat/ola/vn/message/u;


# instance fields
.field protected a:I

.field protected b:Lchat/ola/vn/entity/k;


# direct methods
.method public constructor <init>(Lchat/ola/vn/entity/k;)V
    .locals 1

    iget-object v0, p1, Lchat/ola/vn/entity/k;->g:Ljava/lang/String;

    invoke-direct {p0, v0}, Lchat/ola/vn/message/u;-><init>(Ljava/lang/String;)V

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/message/h;->a:I

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/message/h;->b:Lchat/ola/vn/entity/k;

    iput-object p1, p0, Lchat/ola/vn/message/h;->b:Lchat/ola/vn/entity/k;

    return-void
.end method


# virtual methods
.method public Y()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/h;->b:Lchat/ola/vn/entity/k;

    iget-object v0, v0, Lchat/ola/vn/entity/k;->a:Ljava/lang/String;

    return-object v0
.end method

.method public Z()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/h;->b:Lchat/ola/vn/entity/k;

    iget-object v0, v0, Lchat/ola/vn/entity/k;->f:Ljava/lang/String;

    return-object v0
.end method

.method public a(Lchat/ola/vn/message/f;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/message/u;->a(Lchat/ola/vn/message/f;)V

    check-cast p1, Lchat/ola/vn/message/h;

    iget-object p1, p1, Lchat/ola/vn/message/h;->b:Lchat/ola/vn/entity/k;

    iput-object p1, p0, Lchat/ola/vn/message/h;->b:Lchat/ola/vn/entity/k;

    return-void
.end method

.method public a(Landroid/content/Context;)Z
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/message/h;->b:Lchat/ola/vn/entity/k;

    iget-object v0, v0, Lchat/ola/vn/entity/k;->h:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/h;->b:Lchat/ola/vn/entity/k;

    iget-object v0, v0, Lchat/ola/vn/entity/k;->h:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/util/b;->n(Landroid/content/Context;Ljava/lang/String;)V

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, p0, Lchat/ola/vn/message/h;->b:Lchat/ola/vn/entity/k;

    iget-object v0, v0, Lchat/ola/vn/entity/k;->g:Ljava/lang/String;

    const-string v1, "wap"

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->l(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p1, 0x1

    return p1

    :catch_0
    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public aa()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/h;->b:Lchat/ola/vn/entity/k;

    iget-object v0, v0, Lchat/ola/vn/entity/k;->j:Ljava/lang/String;

    return-object v0
.end method

.method public ab()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f0500

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public b(Lchat/ola/vn/message/f;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/message/u;->b(Lchat/ola/vn/message/f;)V

    check-cast p1, Lchat/ola/vn/message/h;

    iget-object p1, p1, Lchat/ola/vn/message/h;->b:Lchat/ola/vn/entity/k;

    iput-object p1, p0, Lchat/ola/vn/message/h;->b:Lchat/ola/vn/entity/k;

    return-void
.end method
