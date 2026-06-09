.class final Lchat/ola/vn/activity/BuyVipActivity$4;
.super Lchat/ola/vn/entry/c/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/BuyVipActivity;->a(Landroid/content/Context;Landroid/content/Intent;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/i/c;

.field final synthetic b:Landroid/content/Context;

.field final synthetic c:Landroid/content/Intent;


# direct methods
.method constructor <init>(Lchat/ola/vn/i/c;Landroid/content/Context;Landroid/content/Intent;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity$4;->a:Lchat/ola/vn/i/c;

    iput-object p2, p0, Lchat/ola/vn/activity/BuyVipActivity$4;->b:Landroid/content/Context;

    iput-object p3, p0, Lchat/ola/vn/activity/BuyVipActivity$4;->c:Landroid/content/Intent;

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/16 v0, 0xa

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity$4;->a:Lchat/ola/vn/i/c;

    invoke-virtual {p1}, Lchat/ola/vn/i/c;->a()V

    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity$4;->a:Lchat/ola/vn/i/c;

    invoke-virtual {v0}, Lchat/ola/vn/i/c;->a()V

    const/4 v0, 0x0

    aget-object v0, p1, v0

    check-cast v0, Ljava/util/List;

    invoke-static {v0}, Lchat/ola/vn/activity/BuyVipActivity;->c(Ljava/util/List;)Ljava/util/List;

    const/4 v0, 0x1

    aget-object p1, p1, v0

    check-cast p1, Ljava/util/List;

    invoke-static {p1}, Lchat/ola/vn/activity/BuyVipActivity;->d(Ljava/util/List;)Ljava/util/List;

    invoke-static {}, Lchat/ola/vn/activity/BuyVipActivity;->D()Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_3

    invoke-static {}, Lchat/ola/vn/activity/BuyVipActivity;->E()Ljava/util/List;

    move-result-object p1

    if-nez p1, :cond_0

    return-void

    :cond_0
    invoke-static {}, Lchat/ola/vn/activity/BuyVipActivity;->E()Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_1
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/ah;

    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object v1

    invoke-virtual {v0}, Lchat/ola/vn/entity/ah;->b()I

    move-result v2

    invoke-virtual {v1, v2}, Lchat/ola/vn/j;->b(I)Lchat/ola/vn/entity/ah;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-virtual {v0}, Lchat/ola/vn/entity/ah;->b()I

    move-result v2

    invoke-virtual {v1}, Lchat/ola/vn/entity/ah;->b()I

    move-result v3

    if-ne v2, v3, :cond_1

    invoke-virtual {v1}, Lchat/ola/vn/entity/ah;->e()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Lchat/ola/vn/entity/ah;->b(Ljava/lang/String;)V

    invoke-virtual {v1}, Lchat/ola/vn/entity/ah;->d()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/ah;->a(Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity$4;->b:Landroid/content/Context;

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity$4;->c:Landroid/content/Intent;

    invoke-virtual {p1, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :cond_3
    return-void
.end method
