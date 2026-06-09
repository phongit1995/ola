.class Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$b$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/util/Comparator;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$b;->a(Ljava/util/List;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/Comparator<",
        "Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$b;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$b;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$b$1;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;)I
    .locals 5

    iget-wide v0, p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->a:J

    iget-wide v2, p2, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->a:J

    cmp-long v4, v0, v2

    if-lez v4, :cond_0

    const/4 p1, -0x1

    return p1

    :cond_0
    iget-wide v0, p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->a:J

    iget-wide p1, p2, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->a:J

    cmp-long v2, v0, p1

    if-gez v2, :cond_1

    const/4 p1, 0x1

    return p1

    :cond_1
    const/4 p1, 0x0

    return p1
.end method

.method public synthetic compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 0

    check-cast p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;

    check-cast p2, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$b$1;->a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;)I

    move-result p1

    return p1
.end method
