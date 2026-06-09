.class Lchat/ola/vn/m/l$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/l;->j()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/l;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/l;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/l$2;->a:Lchat/ola/vn/m/l;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/f;->e()I

    move-result v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-ne v0, v1, :cond_1

    invoke-static {}, Lchat/ola/vn/m/l;->c()I

    move-result v0

    if-ltz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/l$2;->a:Lchat/ola/vn/m/l;

    invoke-static {v0}, Lchat/ola/vn/m/l;->d(Lchat/ola/vn/m/l;)Landroid/widget/ListView;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/m/l;->c()I

    move-result v1

    invoke-static {}, Lchat/ola/vn/m/l;->d()I

    move-result v2

    :goto_0
    invoke-virtual {v0, v1, v2}, Landroid/widget/ListView;->setSelectionFromTop(II)V

    goto :goto_2

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/l$2;->a:Lchat/ola/vn/m/l;

    :goto_1
    invoke-static {v0}, Lchat/ola/vn/m/l;->d(Lchat/ola/vn/m/l;)Landroid/widget/ListView;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/widget/ListView;->setSelection(I)V

    goto :goto_2

    :cond_1
    invoke-static {}, Lchat/ola/vn/m/l;->e()I

    move-result v0

    if-ltz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/m/l$2;->a:Lchat/ola/vn/m/l;

    invoke-static {v0}, Lchat/ola/vn/m/l;->d(Lchat/ola/vn/m/l;)Landroid/widget/ListView;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/m/l;->e()I

    move-result v1

    invoke-static {}, Lchat/ola/vn/m/l;->h()I

    move-result v2

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/m/l$2;->a:Lchat/ola/vn/m/l;

    goto :goto_1

    :goto_2
    iget-object v0, p0, Lchat/ola/vn/m/l$2;->a:Lchat/ola/vn/m/l;

    invoke-static {v0}, Lchat/ola/vn/m/l;->d(Lchat/ola/vn/m/l;)Landroid/widget/ListView;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/m/l$2$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/m/l$2$1;-><init>(Lchat/ola/vn/m/l$2;)V

    const-wide/16 v2, 0x3e8

    invoke-virtual {v0, v1, v2, v3}, Landroid/widget/ListView;->postDelayed(Ljava/lang/Runnable;J)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
