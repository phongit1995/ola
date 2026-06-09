.class Lchat/ola/vn/m/d$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/n/b$b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/d;->onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/d;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/d;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/d$1;->a:Lchat/ola/vn/m/d;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private d()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/d$1;->a:Lchat/ola/vn/m/d;

    invoke-static {v0}, Lchat/ola/vn/m/d;->a(Lchat/ola/vn/m/d;)Lchat/ola/vn/i/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/i/c;->a()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iget-object v0, p0, Lchat/ola/vn/m/d$1;->a:Lchat/ola/vn/m/d;

    invoke-virtual {v0}, Lchat/ola/vn/m/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const/16 v1, 0xd

    invoke-static {v0, v1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Landroid/content/Context;I)V

    return-void
.end method


# virtual methods
.method public a(DDF)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/d$1;->d()V

    return-void
.end method

.method public j_()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/m/d$1;->a:Lchat/ola/vn/m/d;

    invoke-static {v0}, Lchat/ola/vn/m/d;->a(Lchat/ola/vn/m/d;)Lchat/ola/vn/i/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/i/c;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/d$1;->a:Lchat/ola/vn/m/d;

    invoke-static {v0}, Lchat/ola/vn/m/d;->a(Lchat/ola/vn/m/d;)Lchat/ola/vn/i/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/i/c;->a()V

    iget-object v0, p0, Lchat/ola/vn/m/d$1;->a:Lchat/ola/vn/m/d;

    invoke-virtual {v0}, Lchat/ola/vn/m/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const v1, 0x7f0f009f

    const v2, 0x7f0f02d6

    invoke-static {v0, v1, v2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    :cond_0
    return-void
.end method

.method public k_()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/m/d$1;->a:Lchat/ola/vn/m/d;

    invoke-static {v0}, Lchat/ola/vn/m/d;->a(Lchat/ola/vn/m/d;)Lchat/ola/vn/i/c;

    move-result-object v0

    const-wide/16 v1, 0x7530

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/i/c;->a(JLjava/lang/Runnable;)V

    return-void
.end method

.method public l_()V
    .locals 7

    iget-object v0, p0, Lchat/ola/vn/m/d$1;->a:Lchat/ola/vn/m/d;

    invoke-static {v0}, Lchat/ola/vn/m/d;->a(Lchat/ola/vn/m/d;)Lchat/ola/vn/i/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/i/c;->a()V

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v1

    new-instance v6, Lchat/ola/vn/m/d$1$1;

    invoke-direct {v6, p0}, Lchat/ola/vn/m/d$1$1;-><init>(Lchat/ola/vn/m/d$1;)V

    const v2, 0x7f0f02a1

    const v3, 0x7f0f02a2

    const v4, 0x7f0f065f

    const v5, 0x7f0f0480

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    return-void
.end method
