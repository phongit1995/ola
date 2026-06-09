.class Lchat/ola/vn/activity/OlaChatViewActivity$18;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaChatViewActivity;->o(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lchat/ola/vn/activity/OlaChatViewActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaChatViewActivity;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$18;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$18;->a:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$18;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$18;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->o(Lchat/ola/vn/activity/OlaChatViewActivity;)Landroid/widget/TextView;

    move-result-object v0

    const/16 v1, 0x8

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$18;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->o(Lchat/ola/vn/activity/OlaChatViewActivity;)Landroid/widget/TextView;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$18;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$18;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->o(Lchat/ola/vn/activity/OlaChatViewActivity;)Landroid/widget/TextView;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v1, 0x0

    goto :goto_0

    :catch_0
    return-void
.end method
