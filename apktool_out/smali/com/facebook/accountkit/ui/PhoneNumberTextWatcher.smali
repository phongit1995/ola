.class public Lcom/facebook/accountkit/ui/PhoneNumberTextWatcher;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/text/TextWatcher;


# instance fields
.field private mFormatter:Lcom/google/i18n/phonenumbers/AsYouTypeFormatter;

.field private mSelfChange:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/facebook/accountkit/ui/PhoneNumberTextWatcher;-><init>(Ljava/lang/String;)V

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/facebook/accountkit/ui/PhoneNumberTextWatcher;->mSelfChange:Z

    if-nez p1, :cond_0

    new-instance p1, Ljava/lang/IllegalArgumentException;

    invoke-direct {p1}, Ljava/lang/IllegalArgumentException;-><init>()V

    throw p1

    :cond_0
    invoke-static {}, Lcom/google/i18n/phonenumbers/PhoneNumberUtil;->getInstance()Lcom/google/i18n/phonenumbers/PhoneNumberUtil;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/i18n/phonenumbers/PhoneNumberUtil;->getAsYouTypeFormatter(Ljava/lang/String;)Lcom/google/i18n/phonenumbers/AsYouTypeFormatter;

    move-result-object p1

    iput-object p1, p0, Lcom/facebook/accountkit/ui/PhoneNumberTextWatcher;->mFormatter:Lcom/google/i18n/phonenumbers/AsYouTypeFormatter;

    return-void
.end method

.method private getFormattedNumber(CZ)Ljava/lang/String;
    .locals 0

    if-eqz p2, :cond_0

    iget-object p2, p0, Lcom/facebook/accountkit/ui/PhoneNumberTextWatcher;->mFormatter:Lcom/google/i18n/phonenumbers/AsYouTypeFormatter;

    invoke-virtual {p2, p1}, Lcom/google/i18n/phonenumbers/AsYouTypeFormatter;->inputDigitAndRememberPosition(C)Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_0
    iget-object p2, p0, Lcom/facebook/accountkit/ui/PhoneNumberTextWatcher;->mFormatter:Lcom/google/i18n/phonenumbers/AsYouTypeFormatter;

    invoke-virtual {p2, p1}, Lcom/google/i18n/phonenumbers/AsYouTypeFormatter;->inputDigit(C)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method private reformat(Ljava/lang/CharSequence;I)Ljava/lang/String;
    .locals 9
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    const/4 v0, 0x1

    sub-int/2addr p2, v0

    iget-object v1, p0, Lcom/facebook/accountkit/ui/PhoneNumberTextWatcher;->mFormatter:Lcom/google/i18n/phonenumbers/AsYouTypeFormatter;

    invoke-virtual {v1}, Lcom/google/i18n/phonenumbers/AsYouTypeFormatter;->clear()V

    invoke-interface {p1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    const/4 v2, 0x0

    const/4 v3, 0x0

    move-object v6, v3

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    :goto_0
    if-ge v3, v1, :cond_3

    invoke-interface {p1, v3}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v7

    invoke-static {v7}, Landroid/telephony/PhoneNumberUtils;->isNonSeparator(C)Z

    move-result v8

    if-eqz v8, :cond_1

    if-eqz v4, :cond_0

    invoke-direct {p0, v4, v5}, Lcom/facebook/accountkit/ui/PhoneNumberTextWatcher;->getFormattedNumber(CZ)Ljava/lang/String;

    move-result-object v6

    const/4 v5, 0x0

    :cond_0
    move v4, v7

    :cond_1
    if-ne v3, p2, :cond_2

    const/4 v5, 0x1

    :cond_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_3
    if-eqz v4, :cond_4

    invoke-direct {p0, v4, v5}, Lcom/facebook/accountkit/ui/PhoneNumberTextWatcher;->getFormattedNumber(CZ)Ljava/lang/String;

    move-result-object v6

    :cond_4
    return-object v6
.end method


# virtual methods
.method public declared-synchronized afterTextChanged(Landroid/text/Editable;)V
    .locals 8

    monitor-enter p0

    :try_start_0
    iget-boolean v0, p0, Lcom/facebook/accountkit/ui/PhoneNumberTextWatcher;->mSelfChange:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v0, :cond_0

    monitor-exit p0

    return-void

    :cond_0
    :try_start_1
    invoke-static {p1}, Landroid/text/Selection;->getSelectionEnd(Ljava/lang/CharSequence;)I

    move-result v0

    invoke-direct {p0, p1, v0}, Lcom/facebook/accountkit/ui/PhoneNumberTextWatcher;->reformat(Ljava/lang/CharSequence;I)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v1, p0, Lcom/facebook/accountkit/ui/PhoneNumberTextWatcher;->mFormatter:Lcom/google/i18n/phonenumbers/AsYouTypeFormatter;

    invoke-virtual {v1}, Lcom/google/i18n/phonenumbers/AsYouTypeFormatter;->getRememberedPosition()I

    move-result v7

    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/facebook/accountkit/ui/PhoneNumberTextWatcher;->mSelfChange:Z

    const/4 v2, 0x0

    invoke-interface {p1}, Landroid/text/Editable;->length()I

    move-result v3

    const/4 v5, 0x0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v6

    move-object v1, p1

    move-object v4, v0

    invoke-interface/range {v1 .. v6}, Landroid/text/Editable;->replace(IILjava/lang/CharSequence;II)Landroid/text/Editable;

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-static {p1, v7}, Landroid/text/Selection;->setSelection(Landroid/text/Spannable;I)V

    :cond_1
    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/facebook/accountkit/ui/PhoneNumberTextWatcher;->mSelfChange:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :cond_2
    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    monitor-enter p0

    :try_start_0
    iget-boolean p1, p0, Lcom/facebook/accountkit/ui/PhoneNumberTextWatcher;->mSelfChange:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz p1, :cond_0

    monitor-exit p0

    return-void

    :cond_0
    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    monitor-enter p0

    :try_start_0
    iget-boolean p1, p0, Lcom/facebook/accountkit/ui/PhoneNumberTextWatcher;->mSelfChange:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz p1, :cond_0

    monitor-exit p0

    return-void

    :cond_0
    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method
