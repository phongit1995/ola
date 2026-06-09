.class Lchat/ola/vn/view/c$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/view/c;->a(FFFFLjava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:F

.field final synthetic b:J

.field final synthetic c:F

.field final synthetic d:F

.field final synthetic e:F

.field final synthetic f:F

.field final synthetic g:Ljava/lang/Runnable;

.field final synthetic h:Lchat/ola/vn/view/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/view/c;FJFFFFLjava/lang/Runnable;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/c$2;->h:Lchat/ola/vn/view/c;

    iput p2, p0, Lchat/ola/vn/view/c$2;->a:F

    iput-wide p3, p0, Lchat/ola/vn/view/c$2;->b:J

    iput p5, p0, Lchat/ola/vn/view/c$2;->c:F

    iput p6, p0, Lchat/ola/vn/view/c$2;->d:F

    iput p7, p0, Lchat/ola/vn/view/c$2;->e:F

    iput p8, p0, Lchat/ola/vn/view/c$2;->f:F

    iput-object p9, p0, Lchat/ola/vn/view/c$2;->g:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget v2, p0, Lchat/ola/vn/view/c$2;->a:F

    iget-wide v3, p0, Lchat/ola/vn/view/c$2;->b:J

    sub-long v5, v0, v3

    long-to-float v0, v5

    invoke-static {v2, v0}, Ljava/lang/Math;->min(FF)F

    move-result v0

    iget v1, p0, Lchat/ola/vn/view/c$2;->c:F

    iget v2, p0, Lchat/ola/vn/view/c$2;->d:F

    mul-float v2, v2, v0

    add-float/2addr v1, v2

    iget-object v2, p0, Lchat/ola/vn/view/c$2;->h:Lchat/ola/vn/view/c;

    iget v3, p0, Lchat/ola/vn/view/c$2;->e:F

    iget v4, p0, Lchat/ola/vn/view/c$2;->f:F

    invoke-virtual {v2, v1, v3, v4}, Lchat/ola/vn/view/c;->a(FFF)V

    iget v1, p0, Lchat/ola/vn/view/c$2;->a:F

    cmpg-float v0, v0, v1

    if-gez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/c$2;->h:Lchat/ola/vn/view/c;

    iget-object v0, v0, Lchat/ola/vn/view/c;->q:Landroid/os/Handler;

    invoke-virtual {v0, p0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/c$2;->g:Ljava/lang/Runnable;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/view/c$2;->g:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    :cond_1
    return-void
.end method
