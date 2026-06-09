.class public Lcom/facebook/accountkit/ui/BaseUIManager;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/os/Parcelable;
.implements Lcom/facebook/accountkit/ui/UIManager;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/facebook/accountkit/ui/BaseUIManager;",
            ">;"
        }
    .end annotation
.end field

.field public static final THEME_ID_NOT_SET:I = -0x1


# instance fields
.field private bodyFragment:Landroid/app/Fragment;

.field private flowState:Lcom/facebook/accountkit/ui/LoginFlowState;

.field private footerFragment:Landroid/app/Fragment;

.field private headerFragment:Landroid/app/Fragment;

.field protected listener:Lcom/facebook/accountkit/ui/UIManager$UIManagerListener;

.field private themeId:I
    .annotation build Landroid/support/annotation/StyleRes;
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/facebook/accountkit/ui/BaseUIManager$1;

    invoke-direct {v0}, Lcom/facebook/accountkit/ui/BaseUIManager$1;-><init>()V

    sput-object v0, Lcom/facebook/accountkit/ui/BaseUIManager;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>(I)V
    .locals 0
    .param p1    # I
        .annotation build Landroid/support/annotation/StyleRes;
        .end annotation
    .end param

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lcom/facebook/accountkit/ui/BaseUIManager;->themeId:I

    sget-object p1, Lcom/facebook/accountkit/ui/LoginFlowState;->NONE:Lcom/facebook/accountkit/ui/LoginFlowState;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/BaseUIManager;->flowState:Lcom/facebook/accountkit/ui/LoginFlowState;

    return-void
.end method

.method protected constructor <init>(Landroid/os/Parcel;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Lcom/facebook/accountkit/ui/BaseUIManager;->themeId:I

    invoke-static {}, Lcom/facebook/accountkit/ui/LoginFlowState;->values()[Lcom/facebook/accountkit/ui/LoginFlowState;

    move-result-object v0

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result p1

    aget-object p1, v0, p1

    iput-object p1, p0, Lcom/facebook/accountkit/ui/BaseUIManager;->flowState:Lcom/facebook/accountkit/ui/LoginFlowState;

    return-void
.end method

.method static getDefaultBodyFragment(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;
    .locals 2
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    sget-object v0, Lcom/facebook/accountkit/ui/BaseUIManager$2;->$SwitchMap$com$facebook$accountkit$ui$LoginFlowState:[I

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/LoginFlowState;->ordinal()I

    move-result v1

    aget v0, v0, v1

    packed-switch v0, :pswitch_data_0

    :pswitch_0
    invoke-static {p0, p1}, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory;->create(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/LoginFlowState;)Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    move-result-object p0

    return-object p0

    :pswitch_1
    sget v0, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_verifying_code_center:I

    goto :goto_0

    :pswitch_2
    sget v0, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_verified_code_center:I

    goto :goto_0

    :pswitch_3
    sget v0, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_sending_code_center:I

    goto :goto_0

    :pswitch_4
    sget v0, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_phone_login_center:I

    goto :goto_0

    :pswitch_5
    sget v0, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_error_center:I

    goto :goto_0

    :pswitch_6
    sget v0, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_email_verify_center:I

    goto :goto_0

    :pswitch_7
    sget v0, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_email_login_center:I

    goto :goto_0

    :pswitch_8
    sget v0, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_confirmation_code_center:I

    goto :goto_0

    :pswitch_9
    sget v0, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_sent_code_center:I

    :goto_0
    invoke-static {p0, p1, v0}, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory;->create(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/LoginFlowState;I)Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    move-result-object p0

    return-object p0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_9
        :pswitch_0
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_3
        :pswitch_9
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method static getDefaultBodyFragment(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/UpdateFlowState;)Landroid/app/Fragment;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/BaseUIManager$2;->$SwitchMap$com$facebook$accountkit$ui$UpdateFlowState:[I

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/UpdateFlowState;->ordinal()I

    move-result p1

    aget p1, v0, p1

    packed-switch p1, :pswitch_data_0

    sget-object p1, Lcom/facebook/accountkit/ui/LoginFlowState;->NONE:Lcom/facebook/accountkit/ui/LoginFlowState;

    invoke-static {p0, p1}, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory;->create(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/LoginFlowState;)Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    move-result-object p0

    return-object p0

    :pswitch_0
    sget-object p1, Lcom/facebook/accountkit/ui/LoginFlowState;->NONE:Lcom/facebook/accountkit/ui/LoginFlowState;

    sget v0, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_verifying_code_center:I

    goto :goto_0

    :pswitch_1
    sget-object p1, Lcom/facebook/accountkit/ui/LoginFlowState;->NONE:Lcom/facebook/accountkit/ui/LoginFlowState;

    sget v0, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_verified_code_center:I

    goto :goto_0

    :pswitch_2
    sget-object p1, Lcom/facebook/accountkit/ui/LoginFlowState;->NONE:Lcom/facebook/accountkit/ui/LoginFlowState;

    sget v0, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_sent_code_center:I

    goto :goto_0

    :pswitch_3
    sget-object p1, Lcom/facebook/accountkit/ui/LoginFlowState;->NONE:Lcom/facebook/accountkit/ui/LoginFlowState;

    sget v0, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_sending_code_center:I

    goto :goto_0

    :pswitch_4
    sget-object p1, Lcom/facebook/accountkit/ui/LoginFlowState;->NONE:Lcom/facebook/accountkit/ui/LoginFlowState;

    sget v0, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_phone_login_center:I

    goto :goto_0

    :pswitch_5
    sget-object p1, Lcom/facebook/accountkit/ui/LoginFlowState;->NONE:Lcom/facebook/accountkit/ui/LoginFlowState;

    sget v0, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_error_center:I

    goto :goto_0

    :pswitch_6
    sget-object p1, Lcom/facebook/accountkit/ui/LoginFlowState;->NONE:Lcom/facebook/accountkit/ui/LoginFlowState;

    sget v0, Lcom/facebook/accountkit/R$layout;->com_accountkit_fragment_confirmation_code_center:I

    :goto_0
    invoke-static {p0, p1, v0}, Lcom/facebook/accountkit/ui/StaticContentFragmentFactory;->create(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/LoginFlowState;I)Lcom/facebook/accountkit/ui/StaticContentFragmentFactory$StaticContentFragment;

    move-result-object p0

    return-object p0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_6
        :pswitch_5
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method static getDefaultFooterFragment(Lcom/facebook/accountkit/ui/UIManager;)Landroid/app/Fragment;
    .locals 0
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    invoke-static {p0}, Lcom/facebook/accountkit/ui/TitleFragmentFactory;->create(Lcom/facebook/accountkit/ui/UIManager;)Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    move-result-object p0

    return-object p0
.end method

.method static getDefaultHeaderFragment(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/LoginFlowState;Lcom/facebook/accountkit/ui/LoginType;Lcom/facebook/accountkit/ui/NotificationChannel;)Landroid/app/Fragment;
    .locals 1
    .param p3    # Lcom/facebook/accountkit/ui/NotificationChannel;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    sget-object v0, Lcom/facebook/accountkit/ui/BaseUIManager$2;->$SwitchMap$com$facebook$accountkit$ui$LoginFlowState:[I

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/LoginFlowState;->ordinal()I

    move-result p1

    aget p1, v0, p1

    const/4 v0, -0x1

    packed-switch p1, :pswitch_data_0

    const/4 p1, -0x1

    goto :goto_0

    :pswitch_0
    sget p1, Lcom/facebook/accountkit/R$string;->com_accountkit_resend_title:I

    goto :goto_0

    :pswitch_1
    sget p1, Lcom/facebook/accountkit/R$string;->com_accountkit_verify_title:I

    goto :goto_0

    :pswitch_2
    sget p1, Lcom/facebook/accountkit/R$string;->com_accountkit_success_title:I

    goto :goto_0

    :pswitch_3
    sget p1, Lcom/facebook/accountkit/R$string;->com_accountkit_sent_title:I

    goto :goto_0

    :pswitch_4
    sget-object p1, Lcom/facebook/accountkit/ui/BaseUIManager$2;->$SwitchMap$com$facebook$accountkit$ui$LoginType:[I

    invoke-virtual {p2}, Lcom/facebook/accountkit/ui/LoginType;->ordinal()I

    move-result p2

    aget p1, p1, p2

    packed-switch p1, :pswitch_data_1

    new-instance p0, Lcom/facebook/accountkit/AccountKitException;

    sget-object p1, Lcom/facebook/accountkit/AccountKitError$Type;->INTERNAL_ERROR:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object p2, Lcom/facebook/accountkit/internal/InternalAccountKitError;->UNEXPECTED_STATE:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-direct {p0, p1, p2}, Lcom/facebook/accountkit/AccountKitException;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    throw p0

    :pswitch_5
    sget p1, Lcom/facebook/accountkit/R$string;->com_accountkit_email_loading_title:I

    goto :goto_0

    :pswitch_6
    sget-object p1, Lcom/facebook/accountkit/ui/NotificationChannel;->FACEBOOK:Lcom/facebook/accountkit/ui/NotificationChannel;

    if-ne p3, p1, :cond_0

    sget p1, Lcom/facebook/accountkit/R$string;->com_accountkit_phone_sending_code_on_fb_title:I

    goto :goto_0

    :cond_0
    sget p1, Lcom/facebook/accountkit/R$string;->com_accountkit_phone_loading_title:I

    goto :goto_0

    :pswitch_7
    sget p1, Lcom/facebook/accountkit/R$string;->com_accountkit_phone_login_title:I

    goto :goto_0

    :pswitch_8
    sget-object p1, Lcom/facebook/accountkit/ui/BaseUIManager$2;->$SwitchMap$com$facebook$accountkit$ui$LoginType:[I

    invoke-virtual {p2}, Lcom/facebook/accountkit/ui/LoginType;->ordinal()I

    move-result p2

    aget p1, p1, p2

    const/4 p2, 0x1

    if-eq p1, p2, :cond_1

    sget p1, Lcom/facebook/accountkit/R$string;->com_accountkit_error_title:I

    goto :goto_0

    :cond_1
    sget p1, Lcom/facebook/accountkit/R$string;->com_accountkit_phone_error_title:I

    goto :goto_0

    :pswitch_9
    sget p1, Lcom/facebook/accountkit/R$string;->com_accountkit_email_verify_title:I

    goto :goto_0

    :pswitch_a
    sget p1, Lcom/facebook/accountkit/R$string;->com_accountkit_email_login_title:I

    goto :goto_0

    :pswitch_b
    sget p1, Lcom/facebook/accountkit/R$string;->com_accountkit_confirmation_code_title:I

    goto :goto_0

    :pswitch_c
    sget p1, Lcom/facebook/accountkit/R$string;->com_accountkit_account_verified:I

    :goto_0
    if-le p1, v0, :cond_2

    const/4 p2, 0x0

    new-array p2, p2, [Ljava/lang/String;

    invoke-static {p0, p1, p2}, Lcom/facebook/accountkit/ui/TitleFragmentFactory;->create(Lcom/facebook/accountkit/ui/UIManager;I[Ljava/lang/String;)Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    move-result-object p0

    return-object p0

    :cond_2
    invoke-static {p0}, Lcom/facebook/accountkit/ui/TitleFragmentFactory;->create(Lcom/facebook/accountkit/ui/UIManager;)Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    move-result-object p0

    return-object p0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_c
        :pswitch_c
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_4
        :pswitch_c
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x1
        :pswitch_6
        :pswitch_5
    .end packed-switch
.end method

.method static getDefaultHeaderFragment(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/UpdateFlowState;)Landroid/app/Fragment;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/BaseUIManager$2;->$SwitchMap$com$facebook$accountkit$ui$UpdateFlowState:[I

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/UpdateFlowState;->ordinal()I

    move-result p1

    aget p1, v0, p1

    const/4 v0, -0x1

    packed-switch p1, :pswitch_data_0

    const/4 p1, -0x1

    goto :goto_0

    :pswitch_0
    sget p1, Lcom/facebook/accountkit/R$string;->com_accountkit_verify_title:I

    goto :goto_0

    :pswitch_1
    sget p1, Lcom/facebook/accountkit/R$string;->com_accountkit_success_title:I

    goto :goto_0

    :pswitch_2
    sget p1, Lcom/facebook/accountkit/R$string;->com_accountkit_sent_title:I

    goto :goto_0

    :pswitch_3
    sget p1, Lcom/facebook/accountkit/R$string;->com_accountkit_phone_loading_title:I

    goto :goto_0

    :pswitch_4
    sget p1, Lcom/facebook/accountkit/R$string;->com_accountkit_phone_update_title:I

    goto :goto_0

    :pswitch_5
    sget p1, Lcom/facebook/accountkit/R$string;->com_accountkit_phone_error_title:I

    goto :goto_0

    :pswitch_6
    sget p1, Lcom/facebook/accountkit/R$string;->com_accountkit_error_title:I

    goto :goto_0

    :pswitch_7
    sget p1, Lcom/facebook/accountkit/R$string;->com_accountkit_confirmation_code_title:I

    :goto_0
    if-le p1, v0, :cond_0

    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/String;

    invoke-static {p0, p1, v0}, Lcom/facebook/accountkit/ui/TitleFragmentFactory;->create(Lcom/facebook/accountkit/ui/UIManager;I[Ljava/lang/String;)Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    move-result-object p0

    return-object p0

    :cond_0
    invoke-static {p0}, Lcom/facebook/accountkit/ui/TitleFragmentFactory;->create(Lcom/facebook/accountkit/ui/UIManager;)Lcom/facebook/accountkit/ui/TitleFragmentFactory$TitleFragment;

    move-result-object p0

    return-object p0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public getBodyFragment(Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;
    .locals 0
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-virtual {p0, p1}, Lcom/facebook/accountkit/ui/BaseUIManager;->updateFlowState(Lcom/facebook/accountkit/ui/LoginFlowState;)V

    iget-object p1, p0, Lcom/facebook/accountkit/ui/BaseUIManager;->bodyFragment:Landroid/app/Fragment;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/facebook/accountkit/ui/BaseUIManager;->bodyFragment:Landroid/app/Fragment;

    return-object p1

    :cond_0
    iget-object p1, p0, Lcom/facebook/accountkit/ui/BaseUIManager;->flowState:Lcom/facebook/accountkit/ui/LoginFlowState;

    invoke-static {p0, p1}, Lcom/facebook/accountkit/ui/BaseUIManager;->getDefaultBodyFragment(Lcom/facebook/accountkit/ui/UIManager;Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;

    move-result-object p1

    iput-object p1, p0, Lcom/facebook/accountkit/ui/BaseUIManager;->bodyFragment:Landroid/app/Fragment;

    iget-object p1, p0, Lcom/facebook/accountkit/ui/BaseUIManager;->bodyFragment:Landroid/app/Fragment;

    return-object p1
.end method

.method public getButtonType(Lcom/facebook/accountkit/ui/LoginFlowState;)Lcom/facebook/accountkit/ui/ButtonType;
    .locals 0
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-virtual {p0, p1}, Lcom/facebook/accountkit/ui/BaseUIManager;->updateFlowState(Lcom/facebook/accountkit/ui/LoginFlowState;)V

    const/4 p1, 0x0

    return-object p1
.end method

.method getFlowState()Lcom/facebook/accountkit/ui/LoginFlowState;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/BaseUIManager;->flowState:Lcom/facebook/accountkit/ui/LoginFlowState;

    return-object v0
.end method

.method public getFooterFragment(Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;
    .locals 0
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-virtual {p0, p1}, Lcom/facebook/accountkit/ui/BaseUIManager;->updateFlowState(Lcom/facebook/accountkit/ui/LoginFlowState;)V

    iget-object p1, p0, Lcom/facebook/accountkit/ui/BaseUIManager;->footerFragment:Landroid/app/Fragment;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/facebook/accountkit/ui/BaseUIManager;->footerFragment:Landroid/app/Fragment;

    return-object p1

    :cond_0
    invoke-static {p0}, Lcom/facebook/accountkit/ui/BaseUIManager;->getDefaultFooterFragment(Lcom/facebook/accountkit/ui/UIManager;)Landroid/app/Fragment;

    move-result-object p1

    iput-object p1, p0, Lcom/facebook/accountkit/ui/BaseUIManager;->footerFragment:Landroid/app/Fragment;

    iget-object p1, p0, Lcom/facebook/accountkit/ui/BaseUIManager;->footerFragment:Landroid/app/Fragment;

    return-object p1
.end method

.method public getHeaderFragment(Lcom/facebook/accountkit/ui/LoginFlowState;)Landroid/app/Fragment;
    .locals 0
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-virtual {p0, p1}, Lcom/facebook/accountkit/ui/BaseUIManager;->updateFlowState(Lcom/facebook/accountkit/ui/LoginFlowState;)V

    iget-object p1, p0, Lcom/facebook/accountkit/ui/BaseUIManager;->headerFragment:Landroid/app/Fragment;

    return-object p1
.end method

.method public getTextPosition(Lcom/facebook/accountkit/ui/LoginFlowState;)Lcom/facebook/accountkit/ui/TextPosition;
    .locals 0
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-virtual {p0, p1}, Lcom/facebook/accountkit/ui/BaseUIManager;->updateFlowState(Lcom/facebook/accountkit/ui/LoginFlowState;)V

    sget-object p1, Lcom/facebook/accountkit/ui/TextPosition;->BELOW_BODY:Lcom/facebook/accountkit/ui/TextPosition;

    return-object p1
.end method

.method public getThemeId()I
    .locals 1

    iget v0, p0, Lcom/facebook/accountkit/ui/BaseUIManager;->themeId:I

    return v0
.end method

.method public onError(Lcom/facebook/accountkit/AccountKitError;)V
    .locals 0

    return-void
.end method

.method public setThemeId(I)V
    .locals 0
    .param p1    # I
        .annotation build Landroid/support/annotation/StyleRes;
        .end annotation
    .end param

    iput p1, p0, Lcom/facebook/accountkit/ui/BaseUIManager;->themeId:I

    return-void
.end method

.method public setUIManagerListener(Lcom/facebook/accountkit/ui/UIManager$UIManagerListener;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/BaseUIManager;->listener:Lcom/facebook/accountkit/ui/UIManager$UIManagerListener;

    return-void
.end method

.method protected updateFlowState(Lcom/facebook/accountkit/ui/LoginFlowState;)V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/BaseUIManager;->flowState:Lcom/facebook/accountkit/ui/LoginFlowState;

    if-eq v0, p1, :cond_0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/BaseUIManager;->flowState:Lcom/facebook/accountkit/ui/LoginFlowState;

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/BaseUIManager;->headerFragment:Landroid/app/Fragment;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/BaseUIManager;->bodyFragment:Landroid/app/Fragment;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/BaseUIManager;->footerFragment:Landroid/app/Fragment;

    :cond_0
    return-void
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 0

    iget p2, p0, Lcom/facebook/accountkit/ui/BaseUIManager;->themeId:I

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeInt(I)V

    iget-object p2, p0, Lcom/facebook/accountkit/ui/BaseUIManager;->flowState:Lcom/facebook/accountkit/ui/LoginFlowState;

    invoke-virtual {p2}, Lcom/facebook/accountkit/ui/LoginFlowState;->ordinal()I

    move-result p2

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeInt(I)V

    return-void
.end method
