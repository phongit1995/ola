.class Lchat/ola/vn/m/l$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/support/v4/widget/SwipeRefreshLayout$OnRefreshListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/l;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
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

    iput-object p1, p0, Lchat/ola/vn/m/l$1;->a:Lchat/ola/vn/m/l;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onRefresh()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/m/l$1;->a:Lchat/ola/vn/m/l;

    invoke-static {v0}, Lchat/ola/vn/m/l;->a(Lchat/ola/vn/m/l;)V

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/f;->e()I

    move-result v0

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/l$1;->a:Lchat/ola/vn/m/l;

    invoke-static {v0}, Lchat/ola/vn/m/l;->c(Lchat/ola/vn/m/l;)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/l$1;->a:Lchat/ola/vn/m/l;

    invoke-static {v0}, Lchat/ola/vn/m/l;->b(Lchat/ola/vn/m/l;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
