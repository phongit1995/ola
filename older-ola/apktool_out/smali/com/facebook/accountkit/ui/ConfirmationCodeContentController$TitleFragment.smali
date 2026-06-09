.class public abstract Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment;
.super Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/ui/ConfirmationCodeContentController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "TitleFragment"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment$OnCompleteListener;
    }
.end annotation


# instance fields
.field onCompleteListener:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment$OnCompleteListener;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end field

.field phoneNumber:Lcom/facebook/accountkit/PhoneNumber;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end field

.field retry:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment;->retry:Z

    return-void
.end method


# virtual methods
.method public createView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 1

    sget p3, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_title:I

    const/4 v0, 0x0

    invoke-virtual {p1, p3, p2, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    return-object p1
.end method

.method public onResume()V
    .locals 0

    invoke-super {p0}, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;->onResume()V

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment;->setPhoneNumberView()V

    return-void
.end method

.method protected onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1, p2}, Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;->onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment;->setPhoneNumberView()V

    return-void
.end method

.method setOnCompleteListener(Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment$OnCompleteListener;)V
    .locals 0
    .param p1    # Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment$OnCompleteListener;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment;->onCompleteListener:Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment$OnCompleteListener;

    return-void
.end method

.method setPhoneNumber(Lcom/facebook/accountkit/PhoneNumber;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment;->phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment;->setPhoneNumberView()V

    return-void
.end method

.method abstract setPhoneNumberView()V
.end method

.method setRetry(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment;->retry:Z

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ConfirmationCodeContentController$TitleFragment;->setPhoneNumberView()V

    return-void
.end method
