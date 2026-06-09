.class Lchat/ola/vn/activity/ClanManagementActivity$6;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/i/p$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/ClanManagementActivity;->C()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/ClanManagementActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/ClanManagementActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/ClanManagementActivity$6;->a:Lchat/ola/vn/activity/ClanManagementActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;)Z
    .locals 0

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    xor-int/lit8 p1, p1, 0x1

    return p1
.end method
