.class Lchat/ola/vn/activity/OlaWebLoginActivity$1$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaWebLoginActivity$1;->onReceivedError(Landroid/webkit/WebView;ILjava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/webkit/WebView;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Lchat/ola/vn/activity/OlaWebLoginActivity$1;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaWebLoginActivity$1;Landroid/webkit/WebView;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaWebLoginActivity$1$1;->c:Lchat/ola/vn/activity/OlaWebLoginActivity$1;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaWebLoginActivity$1$1;->a:Landroid/webkit/WebView;

    iput-object p3, p0, Lchat/ola/vn/activity/OlaWebLoginActivity$1$1;->b:Ljava/lang/String;

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
    iget-object p2, p0, Lchat/ola/vn/activity/OlaWebLoginActivity$1$1;->a:Landroid/webkit/WebView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaWebLoginActivity$1$1;->b:Ljava/lang/String;

    invoke-virtual {p2, v0}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    :goto_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
