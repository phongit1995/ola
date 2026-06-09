.class Lchat/ola/vn/m/n$3;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/i;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/n;->e(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/n;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/n;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/n$3;->a:Lchat/ola/vn/m/n;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;Z)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/m/n$3;->a:Lchat/ola/vn/m/n;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/m/n;->b(Lchat/ola/vn/m/n;Z)V

    if-eqz p2, :cond_0

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/m/n$3;->a:Lchat/ola/vn/m/n;

    invoke-virtual {p2}, Lchat/ola/vn/m/n;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {p2, v0, p1, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;S)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/m/n$3;->a:Lchat/ola/vn/m/n;

    invoke-static {p1}, Lchat/ola/vn/m/n;->a(Lchat/ola/vn/m/n;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->selectAll()V

    iget-object p1, p0, Lchat/ola/vn/m/n$3;->a:Lchat/ola/vn/m/n;

    invoke-virtual {p1}, Lchat/ola/vn/m/n;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const p2, 0x7f0f00a2

    const v0, 0x7f0f0443

    invoke-static {p1, p2, v0}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
