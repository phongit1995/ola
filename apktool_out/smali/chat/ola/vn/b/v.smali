.class public Lchat/ola/vn/b/v;
.super Lchat/ola/vn/b/h;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/b/h;-><init>(Landroid/content/Context;)V

    return-void
.end method


# virtual methods
.method protected a(ILchat/ola/vn/entry/b/j;Lchat/ola/vn/entry/b;)V
    .locals 1

    if-nez p1, :cond_0

    const p1, 0x7f0800cf

    :goto_0
    invoke-virtual {p2, p1}, Lchat/ola/vn/entry/b/j;->a(I)V

    return-void

    :cond_0
    const/4 v0, 0x1

    if-ne p1, v0, :cond_2

    iget-object p1, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->j()Z

    move-result p1

    if-eqz p1, :cond_1

    const p1, 0x7f0800ab

    goto :goto_0

    :cond_1
    const p1, 0x7f0800ac

    goto :goto_0

    :cond_2
    iget-object p1, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->j()Z

    move-result p1

    if-eqz p1, :cond_3

    const p1, 0x7f0800aa

    goto :goto_0

    :cond_3
    const p1, 0x7f0800a8

    goto :goto_0

    return-void
.end method

.method public notifyDataSetChanged()V
    .locals 1

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->q()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/b/v;->c:Ljava/util/List;

    invoke-super {p0}, Lchat/ola/vn/b/h;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
