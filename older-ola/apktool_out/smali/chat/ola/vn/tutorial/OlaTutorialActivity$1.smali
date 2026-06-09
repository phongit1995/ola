.class Lchat/ola/vn/tutorial/OlaTutorialActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/tutorial/OlaTutorialActivity;->c(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/tutorial/OlaTutorialActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/tutorial/OlaTutorialActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity$1;->a:Lchat/ola/vn/tutorial/OlaTutorialActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity$1;->a:Lchat/ola/vn/tutorial/OlaTutorialActivity;

    invoke-static {v0}, Lchat/ola/vn/tutorial/OlaTutorialActivity;->a(Lchat/ola/vn/tutorial/OlaTutorialActivity;)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/tutorial/OlaTutorialActivity$1;->a:Lchat/ola/vn/tutorial/OlaTutorialActivity;

    const v1, 0x7f0f00a2

    const v2, 0x7f0f02fe

    invoke-static {v0, v1, v2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    return-void
.end method
