.class Lchat/ola/vn/message/OlaChatBlockedListActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/message/OlaChatBlockedListActivity;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/message/OlaChatBlockedListActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/message/OlaChatBlockedListActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity$1;->a:Lchat/ola/vn/message/OlaChatBlockedListActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    if-eqz p2, :cond_0

    return-void

    :cond_0
    :try_start_0
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/network/OlaNetworkService;->q()V

    iget-object p1, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity$1;->a:Lchat/ola/vn/message/OlaChatBlockedListActivity;

    invoke-virtual {p1}, Lchat/ola/vn/message/OlaChatBlockedListActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
