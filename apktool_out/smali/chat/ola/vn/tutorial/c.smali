.class public abstract Lchat/ola/vn/tutorial/c;
.super Lchat/ola/vn/m/f;


# instance fields
.field private a:Lchat/ola/vn/tutorial/c;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/f;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/tutorial/c;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/tutorial/c;->a:Lchat/ola/vn/tutorial/c;

    return-void
.end method

.method public abstract c()Lchat/ola/vn/tutorial/c;
.end method

.method public d()Ljava/lang/String;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public e()V
    .locals 0

    return-void
.end method

.method public final h()Lchat/ola/vn/tutorial/c;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/tutorial/c;->a:Lchat/ola/vn/tutorial/c;

    return-object v0
.end method

.method public j()Lchat/ola/vn/tutorial/OlaTutorialActivity;
    .locals 1

    invoke-virtual {p0}, Lchat/ola/vn/tutorial/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/tutorial/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    instance-of v0, v0, Lchat/ola/vn/tutorial/OlaTutorialActivity;

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/tutorial/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/tutorial/OlaTutorialActivity;

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method
