.class public final Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;
.super Lcom/facebook/accountkit/ui/ContentFragment;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/ui/ResendContentController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "BottomFragment"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$OnCompleteListener;
    }
.end annotation


# static fields
.field private static final FACEBOOK_NOTIFICATION_CHANNEL:Ljava/lang/String;

.field private static final MILLIS_PER_SECOND:J

.field private static final RESEND_TIME_KEY:Ljava/lang/String;

.field private static final TAG:Ljava/lang/String; = "ResendContentController$BottomFragment"

.field private static final VOICE_CALLBACK_NOTIFICATION_CHANNEL:Ljava/lang/String;


# instance fields
.field private countDownHandler:Landroid/os/Handler;

.field private onCompleteListener:Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$OnCompleteListener;

.field private phoneNumber:Ljava/lang/String;

.field private verifyPhoneNumberView:Landroid/widget/TextView;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    sget-object v0, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v1, 0x1

    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/TimeUnit;->toMillis(J)J

    move-result-wide v0

    sput-wide v0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->MILLIS_PER_SECOND:J

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->TAG:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ".FACEBOOK_NOTIFICATION_CHANNEL"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->FACEBOOK_NOTIFICATION_CHANNEL:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->TAG:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ".VOICE_CALLBACK_NOTIFICATION_CHANNEL"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->VOICE_CALLBACK_NOTIFICATION_CHANNEL:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->TAG:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ".RESEND_TIME_KEY"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->RESEND_TIME_KEY:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ContentFragment;-><init>()V

    return-void
.end method

.method static synthetic access$100(Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;)Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$OnCompleteListener;
    .locals 0

    iget-object p0, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->onCompleteListener:Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$OnCompleteListener;

    return-object p0
.end method

.method static synthetic access$200()J
    .locals 2

    sget-wide v0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->MILLIS_PER_SECOND:J

    return-wide v0
.end method

.method static synthetic access$300(Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;)Landroid/os/Handler;
    .locals 0

    iget-object p0, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->countDownHandler:Landroid/os/Handler;

    return-object p0
.end method

.method private setButtonText(Landroid/widget/Button;II)V
    .locals 4
    .param p2    # I
        .annotation build Landroid/support/annotation/StringRes;
        .end annotation
    .end param
    .param p3    # I
        .annotation build Landroid/support/annotation/StringRes;
        .end annotation
    .end param

    new-instance v0, Landroid/text/SpannableStringBuilder;

    invoke-virtual {p0, p2}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-direct {v0, p2}, Landroid/text/SpannableStringBuilder;-><init>(Ljava/lang/CharSequence;)V

    const-string p2, "\n"

    invoke-virtual {v0, p2}, Landroid/text/SpannableStringBuilder;->append(Ljava/lang/CharSequence;)Landroid/text/SpannableStringBuilder;

    move-result-object p2

    new-instance v0, Landroid/text/style/TypefaceSpan;

    const-string v1, "sans-serif-medium"

    invoke-direct {v0, v1}, Landroid/text/style/TypefaceSpan;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v1

    const/16 v2, 0x21

    const/4 v3, 0x0

    invoke-virtual {p2, v0, v3, v1, v2}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    invoke-virtual {p2}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v0

    invoke-virtual {p0, p3}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->getString(I)Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Landroid/text/SpannableStringBuilder;->append(Ljava/lang/CharSequence;)Landroid/text/SpannableStringBuilder;

    new-instance p3, Landroid/text/style/TypefaceSpan;

    const-string v1, "sans-serif-light"

    invoke-direct {p3, v1}, Landroid/text/style/TypefaceSpan;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v1

    invoke-virtual {p2, p3, v0, v1, v2}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    new-instance p3, Landroid/text/style/ForegroundColorSpan;

    invoke-virtual {p1}, Landroid/widget/Button;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->getUIManager()Lcom/facebook/accountkit/ui/UIManager;

    move-result-object v3

    invoke-static {v1, v3}, Lcom/facebook/accountkit/ui/ViewUtility;->getButtonTextColor(Landroid/content/Context;Lcom/facebook/accountkit/ui/UIManager;)I

    move-result v1

    invoke-direct {p3, v1}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    invoke-virtual {p2}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v1

    invoke-virtual {p2, p3, v0, v1, v2}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    invoke-virtual {p1, p2}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method private updateNotificationViews()V
    .locals 5

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->getView()Landroid/view/View;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    sget v1, Lcom/facebook/accountkit/R$id;->com_accountkit_send_in_fb_button:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->areFacebookNotificationsEnabled()Z

    move-result v2

    const/16 v3, 0x8

    const/4 v4, 0x0

    if-eqz v2, :cond_1

    const/4 v2, 0x0

    goto :goto_0

    :cond_1
    const/16 v2, 0x8

    :goto_0
    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    sget v1, Lcom/facebook/accountkit/R$id;->com_accountkit_send_in_phone_call:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->areVoiceCallbackNotificationsEnabled()Z

    move-result v2

    if-eqz v2, :cond_2

    const/4 v2, 0x0

    goto :goto_1

    :cond_2
    const/16 v2, 0x8

    :goto_1
    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    sget v1, Lcom/facebook/accountkit/R$id;->com_accountkit_other_ways_textview:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->areFacebookNotificationsEnabled()Z

    move-result v1

    if-nez v1, :cond_3

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->areVoiceCallbackNotificationsEnabled()Z

    move-result v1

    if-eqz v1, :cond_4

    :cond_3
    const/4 v3, 0x0

    :cond_4
    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method private updatePhoneNumberView()V
    .locals 5

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->isAdded()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->phoneNumber:Ljava/lang/String;

    if-nez v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Landroid/text/SpannableString;

    sget v1, Lcom/facebook/accountkit/R$string;->com_accountkit_code_sent_to:I

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    iget-object v4, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->phoneNumber:Ljava/lang/String;

    aput-object v4, v2, v3

    invoke-virtual {p0, v1, v2}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/text/SpannableString;-><init>(Ljava/lang/CharSequence;)V

    new-instance v1, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$4;

    invoke-direct {v1, p0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$4;-><init>(Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;)V

    invoke-virtual {v0}, Landroid/text/SpannableString;->toString()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->phoneNumber:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    iget-object v3, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->phoneNumber:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    add-int/2addr v3, v2

    const/16 v4, 0x21

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/text/SpannableString;->setSpan(Ljava/lang/Object;III)V

    iget-object v1, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->verifyPhoneNumberView:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->verifyPhoneNumberView:Landroid/widget/TextView;

    invoke-static {}, Landroid/text/method/LinkMovementMethod;->getInstance()Landroid/text/method/MovementMethod;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setMovementMethod(Landroid/text/method/MovementMethod;)V

    :cond_1
    return-void
.end method

.method private updateResendView()V
    .locals 5

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->getView()Landroid/view/View;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    sget v1, Lcom/facebook/accountkit/R$id;->com_accountkit_resend_button:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    check-cast v0, Landroid/widget/Button;

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->getResendTime()J

    move-result-wide v1

    iget-object v3, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->countDownHandler:Landroid/os/Handler;

    new-instance v4, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$5;

    invoke-direct {v4, p0, v1, v2, v0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$5;-><init>(Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;JLandroid/widget/Button;)V

    invoke-virtual {v3, v4}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method private updateViewStates()V
    .locals 0

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->updatePhoneNumberView()V

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->updateNotificationViews()V

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->updateResendView()V

    return-void
.end method


# virtual methods
.method public areFacebookNotificationsEnabled()Z
    .locals 2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    sget-object v1, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->FACEBOOK_NOTIFICATION_CHANNEL:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public areVoiceCallbackNotificationsEnabled()Z
    .locals 2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    sget-object v1, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->VOICE_CALLBACK_NOTIFICATION_CHANNEL:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method protected createView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 1

    sget p3, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_resend_bottom:I

    const/4 v0, 0x0

    invoke-virtual {p1, p3, p2, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    return-object p1
.end method

.method getLoginFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;
    .locals 1

    invoke-static {}, Lcom/facebook/accountkit/ui/ResendContentController;->access$000()Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v0

    return-object v0
.end method

.method public getResendTime()J
    .locals 2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    sget-object v1, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->RESEND_TIME_KEY:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getLong(Ljava/lang/String;)J

    move-result-wide v0

    return-wide v0
.end method

.method isKeyboardFragment()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public bridge synthetic onActivityCreated(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/ContentFragment;->onActivityCreated(Landroid/os/Bundle;)V

    return-void
.end method

.method public bridge synthetic onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/ContentFragment;->onCreate(Landroid/os/Bundle;)V

    return-void
.end method

.method public bridge synthetic onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 0

    invoke-super {p0, p1, p2, p3}, Lcom/facebook/accountkit/ui/ContentFragment;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;

    move-result-object p1

    return-object p1
.end method

.method public onPause()V
    .locals 2

    invoke-super {p0}, Lcom/facebook/accountkit/ui/ContentFragment;->onPause()V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->countDownHandler:Landroid/os/Handler;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacksAndMessages(Ljava/lang/Object;)V

    return-void
.end method

.method public bridge synthetic onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/ContentFragment;->onSaveInstanceState(Landroid/os/Bundle;)V

    return-void
.end method

.method public onStart()V
    .locals 0

    invoke-super {p0}, Lcom/facebook/accountkit/ui/ContentFragment;->onStart()V

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->updateViewStates()V

    return-void
.end method

.method public onViewCreated(Landroid/view/View;Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1, p2}, Lcom/facebook/accountkit/ui/ContentFragment;->onViewCreated(Landroid/view/View;Landroid/os/Bundle;)V

    new-instance p1, Landroid/os/Handler;

    invoke-direct {p1}, Landroid/os/Handler;-><init>()V

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->countDownHandler:Landroid/os/Handler;

    return-void
.end method

.method protected onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1, p2}, Lcom/facebook/accountkit/ui/ContentFragment;->onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V

    sget p2, Lcom/facebook/accountkit/R$id;->com_accountkit_resend_button:I

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    sget v0, Lcom/facebook/accountkit/R$id;->com_accountkit_accountkit_verify_number:I

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->verifyPhoneNumberView:Landroid/widget/TextView;

    if-eqz p2, :cond_0

    new-instance v0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$1;

    invoke-direct {v0, p0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$1;-><init>(Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;)V

    invoke-virtual {p2, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_0
    sget p2, Lcom/facebook/accountkit/R$id;->com_accountkit_send_in_fb_button:I

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/Button;

    sget v0, Lcom/facebook/accountkit/R$string;->com_accountkit_button_send_code_in_fb:I

    sget v1, Lcom/facebook/accountkit/R$string;->com_accountkit_button_send_code_in_fb_details:I

    invoke-direct {p0, p2, v0, v1}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->setButtonText(Landroid/widget/Button;II)V

    new-instance v0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$2;

    invoke-direct {v0, p0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$2;-><init>(Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;)V

    invoke-virtual {p2, v0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    sget p2, Lcom/facebook/accountkit/R$id;->com_accountkit_send_in_phone_call:I

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    invoke-static {}, Lcom/facebook/accountkit/internal/AccountKitController;->getExperimentationConfiguration()Lcom/facebook/accountkit/internal/ExperimentationConfiguration;

    move-result-object p2

    sget-object v0, Lcom/facebook/accountkit/internal/Feature;->CALLBACK_BUTTON_ALTERNATE_TEXT:Lcom/facebook/accountkit/internal/Feature;

    invoke-virtual {p2, v0}, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->getBooleanValue(Lcom/facebook/accountkit/internal/Feature;)Z

    move-result v0

    invoke-virtual {p2}, Lcom/facebook/accountkit/internal/ExperimentationConfiguration;->exists()Z

    move-result p2

    if-eqz p2, :cond_1

    if-eqz v0, :cond_1

    sget p2, Lcom/facebook/accountkit/R$string;->com_accountkit_button_send_code_in_call_from_facebook_details:I

    goto :goto_0

    :cond_1
    sget p2, Lcom/facebook/accountkit/R$string;->com_accountkit_button_send_code_in_call_details:I

    :goto_0
    sget v1, Lcom/facebook/accountkit/R$string;->com_accountkit_button_send_code_in_call:I

    invoke-direct {p0, p1, v1, p2}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->setButtonText(Landroid/widget/Button;II)V

    new-instance p2, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$3;

    invoke-direct {p2, p0, v0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$3;-><init>(Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;Z)V

    invoke-virtual {p1, p2}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->updateViewStates()V

    return-void
.end method

.method public setNotificationChannels(Ljava/util/List;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/facebook/accountkit/ui/NotificationChannel;",
            ">;)V"
        }
    .end annotation

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    sget-object v1, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->FACEBOOK_NOTIFICATION_CHANNEL:Ljava/lang/String;

    sget-object v2, Lcom/facebook/accountkit/ui/NotificationChannel;->FACEBOOK:Lcom/facebook/accountkit/ui/NotificationChannel;

    invoke-interface {p1, v2}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v2

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    sget-object v1, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->VOICE_CALLBACK_NOTIFICATION_CHANNEL:Ljava/lang/String;

    sget-object v2, Lcom/facebook/accountkit/ui/NotificationChannel;->VOICE_CALLBACK:Lcom/facebook/accountkit/ui/NotificationChannel;

    invoke-interface {p1, v2}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result p1

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->updateNotificationViews()V

    return-void
.end method

.method public setOnCompleteListener(Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$OnCompleteListener;)V
    .locals 0
    .param p1    # Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$OnCompleteListener;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->onCompleteListener:Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment$OnCompleteListener;

    return-void
.end method

.method public setPhoneNumber(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->phoneNumber:Ljava/lang/String;

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->updatePhoneNumberView()V

    return-void
.end method

.method public setResendTime(J)V
    .locals 2

    invoke-virtual {p0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->getViewState()Landroid/os/Bundle;

    move-result-object v0

    sget-object v1, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->RESEND_TIME_KEY:Ljava/lang/String;

    invoke-virtual {v0, v1, p1, p2}, Landroid/os/Bundle;->putLong(Ljava/lang/String;J)V

    invoke-direct {p0}, Lcom/facebook/accountkit/ui/ResendContentController$BottomFragment;->updateResendView()V

    return-void
.end method
