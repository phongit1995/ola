.class Lchat/ola/vn/balloon/a/b$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/balloon/a/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/balloon/a/b;


# direct methods
.method constructor <init>(Lchat/ola/vn/balloon/a/b;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/balloon/a/b$1;->a:Lchat/ola/vn/balloon/a/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 8

    iget-object v0, p0, Lchat/ola/vn/balloon/a/b$1;->a:Lchat/ola/vn/balloon/a/b;

    iget-short v0, v0, Lchat/ola/vn/balloon/a/b;->a:S

    const/4 v1, 0x2

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    iget-object v0, p0, Lchat/ola/vn/balloon/a/b$1;->a:Lchat/ola/vn/balloon/a/b;

    invoke-static {v0}, Lchat/ola/vn/balloon/a/b;->a(Lchat/ola/vn/balloon/a/b;)J

    move-result-wide v4

    sub-long v6, v2, v4

    iget-object v0, p0, Lchat/ola/vn/balloon/a/b$1;->a:Lchat/ola/vn/balloon/a/b;

    iget-wide v2, v0, Lchat/ola/vn/balloon/a/b;->e:J

    cmp-long v0, v6, v2

    const/4 v2, 0x3

    if-ltz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/balloon/a/b$1;->a:Lchat/ola/vn/balloon/a/b;

    iget-object v1, p0, Lchat/ola/vn/balloon/a/b$1;->a:Lchat/ola/vn/balloon/a/b;

    invoke-static {v1}, Lchat/ola/vn/balloon/a/b;->b(Lchat/ola/vn/balloon/a/b;)I

    move-result v1

    iget-object v3, p0, Lchat/ola/vn/balloon/a/b$1;->a:Lchat/ola/vn/balloon/a/b;

    invoke-static {v3}, Lchat/ola/vn/balloon/a/b;->c(Lchat/ola/vn/balloon/a/b;)I

    move-result v3

    invoke-static {v0, v1, v3}, Lchat/ola/vn/balloon/a/b;->a(Lchat/ola/vn/balloon/a/b;II)Z

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/balloon/a/b$1;->a:Lchat/ola/vn/balloon/a/b;

    invoke-virtual {v0, v2}, Lchat/ola/vn/balloon/a/b;->a(S)V

    return-void

    :cond_0
    long-to-float v0, v6

    iget-object v3, p0, Lchat/ola/vn/balloon/a/b$1;->a:Lchat/ola/vn/balloon/a/b;

    iget-wide v3, v3, Lchat/ola/vn/balloon/a/b;->e:J

    long-to-float v3, v3

    div-float/2addr v0, v3

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-static {v0, v3}, Ljava/lang/Math;->min(FF)F

    move-result v0

    const/4 v4, 0x0

    invoke-static {v0, v4}, Ljava/lang/Math;->max(FF)F

    move-result v0

    iget-object v4, p0, Lchat/ola/vn/balloon/a/b$1;->a:Lchat/ola/vn/balloon/a/b;

    invoke-static {v4}, Lchat/ola/vn/balloon/a/b;->b(Lchat/ola/vn/balloon/a/b;)I

    move-result v4

    iget-object v5, p0, Lchat/ola/vn/balloon/a/b$1;->a:Lchat/ola/vn/balloon/a/b;

    invoke-static {v5}, Lchat/ola/vn/balloon/a/b;->d(Lchat/ola/vn/balloon/a/b;)I

    move-result v5

    sub-int/2addr v4, v5

    iget-object v5, p0, Lchat/ola/vn/balloon/a/b$1;->a:Lchat/ola/vn/balloon/a/b;

    invoke-static {v5}, Lchat/ola/vn/balloon/a/b;->c(Lchat/ola/vn/balloon/a/b;)I

    move-result v5

    iget-object v6, p0, Lchat/ola/vn/balloon/a/b$1;->a:Lchat/ola/vn/balloon/a/b;

    invoke-static {v6}, Lchat/ola/vn/balloon/a/b;->e(Lchat/ola/vn/balloon/a/b;)I

    move-result v6

    sub-int/2addr v5, v6

    iget-object v6, p0, Lchat/ola/vn/balloon/a/b$1;->a:Lchat/ola/vn/balloon/a/b;

    iget-object v6, v6, Lchat/ola/vn/balloon/a/b;->d:Landroid/view/animation/Interpolator;

    invoke-interface {v6, v0}, Landroid/view/animation/Interpolator;->getInterpolation(F)F

    move-result v6

    int-to-float v4, v4

    mul-float v4, v4, v6

    invoke-static {v4}, Ljava/lang/Math;->round(F)I

    move-result v4

    int-to-float v5, v5

    mul-float v5, v5, v6

    invoke-static {v5}, Ljava/lang/Math;->round(F)I

    move-result v5

    iget-object v6, p0, Lchat/ola/vn/balloon/a/b$1;->a:Lchat/ola/vn/balloon/a/b;

    invoke-static {v6}, Lchat/ola/vn/balloon/a/b;->d(Lchat/ola/vn/balloon/a/b;)I

    move-result v6

    add-int/2addr v6, v4

    iget-object v4, p0, Lchat/ola/vn/balloon/a/b$1;->a:Lchat/ola/vn/balloon/a/b;

    invoke-static {v4}, Lchat/ola/vn/balloon/a/b;->e(Lchat/ola/vn/balloon/a/b;)I

    move-result v4

    add-int/2addr v4, v5

    cmpl-float v0, v0, v3

    if-nez v0, :cond_1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/balloon/a/b$1;->a:Lchat/ola/vn/balloon/a/b;

    invoke-static {v0, v6, v4}, Lchat/ola/vn/balloon/a/b;->a(Lchat/ola/vn/balloon/a/b;II)Z

    move-result v0

    if-eqz v0, :cond_2

    goto :goto_0

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/balloon/a/b$1;->a:Lchat/ola/vn/balloon/a/b;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v0, v2, v3}, Lchat/ola/vn/balloon/a/b;->a(Lchat/ola/vn/balloon/a/b;J)J

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/balloon/a/b$1;->a:Lchat/ola/vn/balloon/a/b;

    invoke-virtual {v0, v1}, Lchat/ola/vn/balloon/a/b;->a(S)V

    :pswitch_2
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_2
    .end packed-switch
.end method
