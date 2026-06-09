.class Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$3;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/text/TextWatcher;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->D()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$3;->a:Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$3;->a:Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;

    invoke-static {v0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->b(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;)Lchat/ola/vn/b/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/b/c;->getFilter()Landroid/widget/Filter;

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
