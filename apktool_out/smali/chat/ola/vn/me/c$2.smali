.class Lchat/ola/vn/me/c$2;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/i;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/c;->h(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/c;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/c$2;->a:Lchat/ola/vn/me/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;Z)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/c$2;->a:Lchat/ola/vn/me/c;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/me/c;->d(Lchat/ola/vn/me/c;Z)V

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/me/c$2;->a:Lchat/ola/vn/me/c;

    invoke-static {p2}, Lchat/ola/vn/me/c;->f(Lchat/ola/vn/me/c;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    move-result-object p2

    const-string v0, ""

    invoke-virtual {p2, v0}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    iget-object p2, p0, Lchat/ola/vn/me/c$2;->a:Lchat/ola/vn/me/c;

    invoke-virtual {p2}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {p2, v0, p1}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/me/c$2;->a:Lchat/ola/vn/me/c;

    invoke-virtual {p1}, Lchat/ola/vn/me/c;->e()V

    iget-object p1, p0, Lchat/ola/vn/me/c$2;->a:Lchat/ola/vn/me/c;

    :goto_0
    invoke-static {p1}, Lchat/ola/vn/me/c;->a(Lchat/ola/vn/me/c;)Lchat/ola/vn/me/b;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/me/b;->notifyDataSetChanged()V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/me/c$2;->a:Lchat/ola/vn/me/c;

    invoke-static {p1}, Lchat/ola/vn/me/c;->f(Lchat/ola/vn/me/c;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->selectAll()V

    iget-object p1, p0, Lchat/ola/vn/me/c$2;->a:Lchat/ola/vn/me/c;

    invoke-virtual {p1}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const p2, 0x7f0f00a2

    const v0, 0x7f0f0443

    invoke-static {p1, p2, v0}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    iget-object p1, p0, Lchat/ola/vn/me/c$2;->a:Lchat/ola/vn/me/c;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    return-void
.end method
