.class Lchat/ola/vn/activity/OlaChatGroupListActivity$1$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaChatGroupListActivity$1;->onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaChatGroupListActivity$1;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaChatGroupListActivity$1;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity$1$1;->a:Lchat/ola/vn/activity/OlaChatGroupListActivity$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 1

    if-eqz p2, :cond_0

    goto :goto_0

    :cond_0
    :try_start_0
    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity$1$1;->a:Lchat/ola/vn/activity/OlaChatGroupListActivity$1;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaChatGroupListActivity$1;->b:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Lchat/ola/vn/network/OlaNetworkService;->k(Ljava/lang/String;)V

    sget-object p2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity$1$1;->a:Lchat/ola/vn/activity/OlaChatGroupListActivity$1;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaChatGroupListActivity$1;->b:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Lchat/ola/vn/message/g;->f(Ljava/lang/String;)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity$1$1;->a:Lchat/ola/vn/activity/OlaChatGroupListActivity$1;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaChatGroupListActivity$1;->c:Lchat/ola/vn/activity/OlaChatGroupListActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaChatGroupListActivity;->a(Lchat/ola/vn/activity/OlaChatGroupListActivity;)Lchat/ola/vn/b/m;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/b/m;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :goto_0
    :try_start_1
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method
