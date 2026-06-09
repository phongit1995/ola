.class Lchat/ola/vn/m/g$7$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/g$7;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/entity/e;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entity/e;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:Lchat/ola/vn/m/g$7;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/g$7;Lchat/ola/vn/entity/e;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/g$7$1;->d:Lchat/ola/vn/m/g$7;

    iput-object p2, p0, Lchat/ola/vn/m/g$7$1;->a:Lchat/ola/vn/entity/e;

    iput-object p3, p0, Lchat/ola/vn/m/g$7$1;->b:Ljava/lang/String;

    iput-object p4, p0, Lchat/ola/vn/m/g$7$1;->c:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/g$7$1;->d:Lchat/ola/vn/m/g$7;

    iget-object v0, v0, Lchat/ola/vn/m/g$7;->c:Lchat/ola/vn/m/g;

    invoke-static {v0}, Lchat/ola/vn/m/g;->b(Lchat/ola/vn/m/g;)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/g$7$1;->d:Lchat/ola/vn/m/g$7;

    iget-object v0, v0, Lchat/ola/vn/m/g$7;->c:Lchat/ola/vn/m/g;

    invoke-static {v0}, Lchat/ola/vn/m/g;->b(Lchat/ola/vn/m/g;)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/g$7$1;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->v()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/m/g$7$1;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->w()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/m/g$7$1;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->m()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/m/g$7$1;->a:Lchat/ola/vn/entity/e;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->e(Z)V

    iget-object v0, p0, Lchat/ola/vn/m/g$7$1;->a:Lchat/ola/vn/entity/e;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->b(Z)V

    iget-object v0, p0, Lchat/ola/vn/m/g$7$1;->a:Lchat/ola/vn/entity/e;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/entity/e;->a(J)V

    invoke-static {}, Lchat/ola/vn/m/g;->y()Lchat/ola/vn/entity/e;

    move-result-object v0

    if-eqz v0, :cond_2

    sget-object v0, Lchat/ola/vn/m/g;->a:Ljava/util/List;

    invoke-static {}, Lchat/ola/vn/m/g;->y()Lchat/ola/vn/entity/e;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/m/g$7$1;->d:Lchat/ola/vn/m/g$7;

    iget-object v0, v0, Lchat/ola/vn/m/g$7;->a:Lchat/ola/vn/entity/e;

    if-nez v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/m/g$7$1;->d:Lchat/ola/vn/m/g$7;

    iget-object v0, v0, Lchat/ola/vn/m/g$7;->b:Lchat/ola/vn/p/b;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/m/g$7$1;->d:Lchat/ola/vn/m/g$7;

    iget-object v0, v0, Lchat/ola/vn/m/g$7;->b:Lchat/ola/vn/p/b;

    iget-object v1, p0, Lchat/ola/vn/m/g$7$1;->b:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/m/g$7$1;->c:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/m/g$7$1;->a:Lchat/ola/vn/entity/e;

    invoke-interface {v0, v1, v2, v3}, Lchat/ola/vn/p/b;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/entity/e;)V

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/m/g$7$1;->d:Lchat/ola/vn/m/g$7;

    iget-object v0, v0, Lchat/ola/vn/m/g$7;->c:Lchat/ola/vn/m/g;

    iget-object v1, p0, Lchat/ola/vn/m/g$7$1;->a:Lchat/ola/vn/entity/e;

    :goto_0
    invoke-static {v0, v1}, Lchat/ola/vn/m/g;->a(Lchat/ola/vn/m/g;Lchat/ola/vn/entity/e;)V

    goto :goto_1

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/m/g$7$1;->d:Lchat/ola/vn/m/g$7;

    iget-object v0, v0, Lchat/ola/vn/m/g$7;->a:Lchat/ola/vn/entity/e;

    iget-object v1, p0, Lchat/ola/vn/m/g$7$1;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->b(Lchat/ola/vn/entity/e;)V

    iget-object v0, p0, Lchat/ola/vn/m/g$7$1;->d:Lchat/ola/vn/m/g$7;

    iget-object v0, v0, Lchat/ola/vn/m/g$7;->b:Lchat/ola/vn/p/b;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/m/g$7$1;->d:Lchat/ola/vn/m/g$7;

    iget-object v0, v0, Lchat/ola/vn/m/g$7;->b:Lchat/ola/vn/p/b;

    iget-object v1, p0, Lchat/ola/vn/m/g$7$1;->b:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/m/g$7$1;->c:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/m/g$7$1;->d:Lchat/ola/vn/m/g$7;

    iget-object v3, v3, Lchat/ola/vn/m/g$7;->a:Lchat/ola/vn/entity/e;

    invoke-interface {v0, v1, v2, v3}, Lchat/ola/vn/p/b;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/entity/e;)V

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/m/g$7$1;->d:Lchat/ola/vn/m/g$7;

    iget-object v0, v0, Lchat/ola/vn/m/g$7;->c:Lchat/ola/vn/m/g;

    iget-object v1, p0, Lchat/ola/vn/m/g$7$1;->d:Lchat/ola/vn/m/g$7;

    iget-object v1, v1, Lchat/ola/vn/m/g$7;->a:Lchat/ola/vn/entity/e;

    goto :goto_0

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/m/g$7$1;->d:Lchat/ola/vn/m/g$7;

    iget-object v0, v0, Lchat/ola/vn/m/g$7;->c:Lchat/ola/vn/m/g;

    invoke-virtual {v0}, Lchat/ola/vn/m/g;->h()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method
