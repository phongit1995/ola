.class Lchat/ola/vn/m/j$2;
.super Lchat/ola/vn/entry/c/d;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/j;->a(Lchat/ola/vn/entity/t;ZLjava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entity/t;

.field final synthetic b:Ljava/lang/Runnable;

.field final synthetic c:Lchat/ola/vn/m/j;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/j;Lchat/ola/vn/entity/t;Ljava/lang/String;Lchat/ola/vn/entity/t;Ljava/lang/Runnable;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/j$2;->c:Lchat/ola/vn/m/j;

    iput-object p4, p0, Lchat/ola/vn/m/j$2;->a:Lchat/ola/vn/entity/t;

    iput-object p5, p0, Lchat/ola/vn/m/j$2;->b:Ljava/lang/Runnable;

    invoke-direct {p0, p2, p3}, Lchat/ola/vn/entry/c/d;-><init>(Lchat/ola/vn/entity/t;Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    invoke-super {p0, p1, p2, p3, p4}, Lchat/ola/vn/entry/c/d;->a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/m/j$2;->c:Lchat/ola/vn/m/j;

    invoke-static {p1}, Lchat/ola/vn/m/j;->h(Lchat/ola/vn/m/j;)Landroid/view/View;

    move-result-object p1

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 4

    invoke-super {p0, p1}, Lchat/ola/vn/entry/c/d;->a([Ljava/lang/Object;)V

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/m/j$2;->c:Lchat/ola/vn/m/j;

    invoke-static {p1}, Lchat/ola/vn/m/j;->h(Lchat/ola/vn/m/j;)Landroid/view/View;

    move-result-object p1

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    new-instance p1, Lchat/ola/vn/m/j$b;

    iget-object v2, p0, Lchat/ola/vn/m/j$2;->c:Lchat/ola/vn/m/j;

    iget-object v3, p0, Lchat/ola/vn/m/j$2;->a:Lchat/ola/vn/entity/t;

    invoke-direct {p1, v2, v3, v0, v1}, Lchat/ola/vn/m/j$b;-><init>(Lchat/ola/vn/m/j;Lchat/ola/vn/entity/t;J)V

    iget-object v2, p0, Lchat/ola/vn/m/j$2;->a:Lchat/ola/vn/entity/t;

    invoke-virtual {v2}, Lchat/ola/vn/entity/t;->w()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/j$2;->c:Lchat/ola/vn/m/j;

    new-instance v1, Lchat/ola/vn/entity/t;

    invoke-direct {v1, v2}, Lchat/ola/vn/entity/t;-><init>(Ljava/lang/String;)V

    const/4 v2, 0x0

    invoke-static {v0, v1, v2, p1}, Lchat/ola/vn/m/j;->a(Lchat/ola/vn/m/j;Lchat/ola/vn/entity/t;ZLjava/lang/Runnable;)V

    return-void

    :cond_0
    iget-object v2, p0, Lchat/ola/vn/m/j$2;->b:Ljava/lang/Runnable;

    if-eqz v2, :cond_2

    sget-object p1, Lchat/ola/vn/m/j;->c:Ljava/util/List;

    iget-object v2, p0, Lchat/ola/vn/m/j$2;->a:Lchat/ola/vn/entity/t;

    invoke-interface {p1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object p1, p0, Lchat/ola/vn/m/j$2;->c:Lchat/ola/vn/m/j;

    invoke-static {p1}, Lchat/ola/vn/m/j;->e(Lchat/ola/vn/m/j;)Lchat/ola/vn/m/j$a;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/m/j$a;->notifyDataSetChanged()V

    iget-object p1, p0, Lchat/ola/vn/m/j$2;->a:Lchat/ola/vn/entity/t;

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/entity/t;->e(J)V

    sget-object p1, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    invoke-virtual {p1}, Lchat/ola/vn/r/b;->a()Z

    move-result p1

    if-eqz p1, :cond_1

    sget-object p1, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    iget-object v0, p0, Lchat/ola/vn/m/j$2;->a:Lchat/ola/vn/entity/t;

    invoke-virtual {p1, v0}, Lchat/ola/vn/r/b;->b(Lchat/ola/vn/entity/t;)V

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/m/j$2;->b:Ljava/lang/Runnable;

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    return-void

    :cond_2
    invoke-virtual {p1}, Lchat/ola/vn/m/j$b;->run()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_1
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method
