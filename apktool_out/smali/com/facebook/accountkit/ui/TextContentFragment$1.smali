.class Lcom/facebook/accountkit/ui/TextContentFragment$1;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/ui/CustomLinkMovement$OnURLClickedListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/TextContentFragment;->onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/TextContentFragment;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/TextContentFragment;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/TextContentFragment$1;->this$0:Lcom/facebook/accountkit/ui/TextContentFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onURLClicked(Ljava/lang/String;)V
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/Buttons;->POLICY_LINKS:Lcom/facebook/accountkit/ui/Buttons;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/Buttons;->name()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p1}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUIPhoneLoginInteraction(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method
