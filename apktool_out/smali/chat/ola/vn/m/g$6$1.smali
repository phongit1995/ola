.class Lchat/ola/vn/m/g$6$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/g$6;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/entity/e;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entity/e;

.field final synthetic b:Lchat/ola/vn/m/g$6;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/g$6;Lchat/ola/vn/entity/e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/g$6$1;->b:Lchat/ola/vn/m/g$6;

    iput-object p2, p0, Lchat/ola/vn/m/g$6$1;->a:Lchat/ola/vn/entity/e;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/m/g$6$1;->b:Lchat/ola/vn/m/g$6;

    iget-object v0, v0, Lchat/ola/vn/m/g$6;->b:Lchat/ola/vn/m/g;

    invoke-static {v0}, Lchat/ola/vn/m/g;->b(Lchat/ola/vn/m/g;)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/g$6$1;->b:Lchat/ola/vn/m/g$6;

    iget-object v0, v0, Lchat/ola/vn/m/g$6;->b:Lchat/ola/vn/m/g;

    invoke-static {v0}, Lchat/ola/vn/m/g;->b(Lchat/ola/vn/m/g;)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/g$6$1;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->v()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/m/g$6$1;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->w()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/m/g$6$1;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->m()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/m/g$6$1;->a:Lchat/ola/vn/entity/e;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->e(Z)V

    iget-object v0, p0, Lchat/ola/vn/m/g$6$1;->a:Lchat/ola/vn/entity/e;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->b(Z)V

    iget-object v0, p0, Lchat/ola/vn/m/g$6$1;->a:Lchat/ola/vn/entity/e;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/entity/e;->a(J)V

    iget-object v0, p0, Lchat/ola/vn/m/g$6$1;->b:Lchat/ola/vn/m/g$6;

    iget-object v0, v0, Lchat/ola/vn/m/g$6;->a:Lchat/ola/vn/entity/e;

    iget-object v1, p0, Lchat/ola/vn/m/g$6$1;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->b(Lchat/ola/vn/entity/e;)V

    iget-object v0, p0, Lchat/ola/vn/m/g$6$1;->b:Lchat/ola/vn/m/g$6;

    iget-object v0, v0, Lchat/ola/vn/m/g$6;->b:Lchat/ola/vn/m/g;

    invoke-virtual {v0}, Lchat/ola/vn/m/g;->h()V

    return-void
.end method
