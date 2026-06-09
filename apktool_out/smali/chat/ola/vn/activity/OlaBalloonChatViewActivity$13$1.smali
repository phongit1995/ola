.class Lchat/ola/vn/activity/OlaBalloonChatViewActivity$13$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaBalloonChatViewActivity$13;->onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$13;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity$13;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$13$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$13;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    if-nez p2, :cond_0

    :try_start_0
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p1, :cond_0

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$13$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$13;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$13;->b:Lchat/ola/vn/message/f;

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/network/OlaNetworkService;->l(Ljava/lang/String;)V

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$13$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$13;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$13;->b:Lchat/ola/vn/message/f;

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/g;->b(Lchat/ola/vn/message/f;)Lchat/ola/vn/message/f;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method
