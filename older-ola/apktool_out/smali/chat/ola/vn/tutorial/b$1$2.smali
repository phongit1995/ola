.class Lchat/ola/vn/tutorial/b$1$2;
.super Lchat/ola/vn/entry/c/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/tutorial/b$1;->d()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/tutorial/b$1;


# direct methods
.method constructor <init>(Lchat/ola/vn/tutorial/b$1;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/tutorial/b$1$2;->a:Lchat/ola/vn/tutorial/b$1;

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/16 v0, 0x11

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/tutorial/b$1$2;->a:Lchat/ola/vn/tutorial/b$1;

    iget-object p1, p1, Lchat/ola/vn/tutorial/b$1;->a:Lchat/ola/vn/tutorial/b;

    invoke-virtual {p1}, Lchat/ola/vn/tutorial/b;->j()Lchat/ola/vn/tutorial/OlaTutorialActivity;

    move-result-object p1

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Lchat/ola/vn/tutorial/OlaTutorialActivity;->c(Z)V

    iget-object p1, p0, Lchat/ola/vn/tutorial/b$1$2;->a:Lchat/ola/vn/tutorial/b$1;

    iget-object p1, p1, Lchat/ola/vn/tutorial/b$1;->a:Lchat/ola/vn/tutorial/b;

    invoke-virtual {p1}, Lchat/ola/vn/tutorial/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-virtual {p1}, Landroid/support/v4/app/FragmentActivity;->finish()V

    iget-object p1, p0, Lchat/ola/vn/tutorial/b$1$2;->a:Lchat/ola/vn/tutorial/b$1;

    iget-object p1, p1, Lchat/ola/vn/tutorial/b$1;->a:Lchat/ola/vn/tutorial/b;

    invoke-virtual {p1}, Lchat/ola/vn/tutorial/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/m/l;->a(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 1

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/tutorial/b$1$2;->a:Lchat/ola/vn/tutorial/b$1;

    iget-object p1, p1, Lchat/ola/vn/tutorial/b$1;->a:Lchat/ola/vn/tutorial/b;

    invoke-virtual {p1}, Lchat/ola/vn/tutorial/b;->j()Lchat/ola/vn/tutorial/OlaTutorialActivity;

    move-result-object p1

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lchat/ola/vn/tutorial/OlaTutorialActivity;->c(Z)V

    iget-object p1, p0, Lchat/ola/vn/tutorial/b$1$2;->a:Lchat/ola/vn/tutorial/b$1;

    iget-object p1, p1, Lchat/ola/vn/tutorial/b$1;->a:Lchat/ola/vn/tutorial/b;

    invoke-virtual {p1}, Lchat/ola/vn/tutorial/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-virtual {p1}, Landroid/support/v4/app/FragmentActivity;->finish()V

    iget-object p1, p0, Lchat/ola/vn/tutorial/b$1$2;->a:Lchat/ola/vn/tutorial/b$1;

    iget-object p1, p1, Lchat/ola/vn/tutorial/b$1;->a:Lchat/ola/vn/tutorial/b;

    invoke-virtual {p1}, Lchat/ola/vn/tutorial/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/m/l;->a(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method
