.class public Lchat/ola/vn/m/q;
.super Lchat/ola/vn/m/p;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/m/p<",
        "Lchat/ola/vn/m/g;",
        ">;"
    }
.end annotation


# instance fields
.field protected a:Lchat/ola/vn/entity/e;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/p;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Landroid/content/Context;)Ljava/util/ArrayList;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/ArrayList<",
            "Lchat/ola/vn/mediastore/a;",
            ">;"
        }
    .end annotation

    const/4 p1, 0x0

    return-object p1
.end method

.method public a(Lchat/ola/vn/entity/e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/q;->a:Lchat/ola/vn/entity/e;

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/m/q;->v()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public c()V
    .locals 0

    return-void
.end method

.method public d_()V
    .locals 0

    return-void
.end method

.method public e()Lchat/ola/vn/m/g;
    .locals 1

    invoke-static {}, Lchat/ola/vn/m/g;->c()Lchat/ola/vn/m/g;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-static {}, Lchat/ola/vn/m/g;->c()Lchat/ola/vn/m/g;

    move-result-object v0

    return-object v0

    :cond_0
    invoke-super {p0}, Lchat/ola/vn/m/p;->g()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/m/g;

    return-object v0
.end method

.method public synthetic g()Ljava/lang/Object;
    .locals 1

    invoke-virtual {p0}, Lchat/ola/vn/m/q;->e()Lchat/ola/vn/m/g;

    move-result-object v0

    return-object v0
.end method

.method public j()V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/m/q;->a:Lchat/ola/vn/entity/e;

    if-eqz v0, :cond_0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-object v2, p0, Lchat/ola/vn/m/q;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v2}, Lchat/ola/vn/entity/e;->d()J

    move-result-wide v2

    sub-long v4, v0, v2

    const-wide/32 v0, 0xea60

    cmp-long v2, v4, v0

    if-lez v2, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/m/q;->e()Lchat/ola/vn/m/g;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/m/q;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0, v1}, Lchat/ola/vn/m/g;->a(Lchat/ola/vn/entity/e;)V

    :cond_0
    return-void
.end method

.method protected v()V
    .locals 0

    return-void
.end method
