.class public abstract Lchat/ola/vn/transferken/a;
.super Lchat/ola/vn/m/f;


# instance fields
.field private a:Lchat/ola/vn/transferken/a;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/f;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/transferken/a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/transferken/a;->a:Lchat/ola/vn/transferken/a;

    return-void
.end method

.method public abstract c()Lchat/ola/vn/transferken/a;
.end method

.method public final d()Lchat/ola/vn/transferken/a;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/transferken/a;->a:Lchat/ola/vn/transferken/a;

    return-object v0
.end method

.method public e()Lchat/ola/vn/transferken/OlaTransferKenActivity;
    .locals 1

    invoke-virtual {p0}, Lchat/ola/vn/transferken/a;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/transferken/a;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    instance-of v0, v0, Lchat/ola/vn/transferken/OlaTransferKenActivity;

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/transferken/a;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/transferken/OlaTransferKenActivity;

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public h()Landroid/content/Intent;
    .locals 1

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/transferken/a;->e()Lchat/ola/vn/transferken/OlaTransferKenActivity;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    return-object v0
.end method

.method public j()V
    .locals 1

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/transferken/a;->e()Lchat/ola/vn/transferken/OlaTransferKenActivity;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
