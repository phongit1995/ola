.class Lchat/ola/vn/checkin/OlaCheckInActivity$3;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/text/TextWatcher;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/checkin/OlaCheckInActivity;->D()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/checkin/OlaCheckInActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/checkin/OlaCheckInActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInActivity$3;->a:Lchat/ola/vn/checkin/OlaCheckInActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 2

    :try_start_0
    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity$3;->a:Lchat/ola/vn/checkin/OlaCheckInActivity;

    invoke-static {v0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->b(Lchat/ola/vn/checkin/OlaCheckInActivity;)Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity$3;->a:Lchat/ola/vn/checkin/OlaCheckInActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/checkin/OlaCheckInActivity;->a(Lchat/ola/vn/checkin/OlaCheckInActivity;Z)Z

    invoke-static {p1}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity$3;->a:Lchat/ola/vn/checkin/OlaCheckInActivity;

    invoke-static {v0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->b(Lchat/ola/vn/checkin/OlaCheckInActivity;)Landroid/widget/TextView;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity$3;->a:Lchat/ola/vn/checkin/OlaCheckInActivity;

    invoke-static {v0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->b(Lchat/ola/vn/checkin/OlaCheckInActivity;)Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInActivity$3;->a:Lchat/ola/vn/checkin/OlaCheckInActivity;

    invoke-static {v0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->c(Lchat/ola/vn/checkin/OlaCheckInActivity;)Lchat/ola/vn/b/p;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/b/p;->getFilter()Landroid/widget/Filter;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/widget/Filter;->filter(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method
