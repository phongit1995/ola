.class public Lchat/ola/vn/message/w;
.super Lchat/ola/vn/message/d;


# instance fields
.field protected z:Lchat/ola/vn/entity/w;


# direct methods
.method public constructor <init>(Lchat/ola/vn/message/d;B)V
    .locals 1

    const/16 v0, 0xe

    invoke-direct {p0, p1, p2, v0}, Lchat/ola/vn/message/d;-><init>(Lchat/ola/vn/message/d;BB)V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/message/w;->z:Lchat/ola/vn/entity/w;

    return-void
.end method


# virtual methods
.method public a()Lchat/ola/vn/entity/w;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/w;->z:Lchat/ola/vn/entity/w;

    return-object v0
.end method

.method public a(Lchat/ola/vn/entity/w;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/w;->z:Lchat/ola/vn/entity/w;

    return-void
.end method

.method a(Lchat/ola/vn/message/d;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/message/d;->a(Lchat/ola/vn/message/d;)V

    :try_start_0
    check-cast p1, Lchat/ola/vn/message/w;

    iget-object v0, p1, Lchat/ola/vn/message/w;->z:Lchat/ola/vn/entity/w;

    if-eqz v0, :cond_0

    iget-object p1, p1, Lchat/ola/vn/message/w;->z:Lchat/ola/vn/entity/w;

    iput-object p1, p0, Lchat/ola/vn/message/w;->z:Lchat/ola/vn/entity/w;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public w()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method
