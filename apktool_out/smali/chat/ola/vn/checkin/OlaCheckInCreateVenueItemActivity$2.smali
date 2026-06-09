.class Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/n/b$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->E()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity$2;->a:Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 0

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Landroid/location/Address;",
            ">;)V"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/location/Address;

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity$2;->a:Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;

    invoke-static {v0}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->a(Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;)Landroid/widget/EditText;

    move-result-object v0

    invoke-static {p1}, Lchat/ola/vn/n/b;->a(Landroid/location/Address;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
