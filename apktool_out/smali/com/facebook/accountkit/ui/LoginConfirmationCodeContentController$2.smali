.class synthetic Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$2;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1008
    name = null
.end annotation


# static fields
.field static final synthetic $SwitchMap$com$facebook$accountkit$ui$NotificationChannel:[I


# direct methods
.method static constructor <clinit>()V
    .locals 3

    invoke-static {}, Lcom/facebook/accountkit/ui/NotificationChannel;->values()[Lcom/facebook/accountkit/ui/NotificationChannel;

    move-result-object v0

    array-length v0, v0

    new-array v0, v0, [I

    sput-object v0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$2;->$SwitchMap$com$facebook$accountkit$ui$NotificationChannel:[I

    :try_start_0
    sget-object v0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$2;->$SwitchMap$com$facebook$accountkit$ui$NotificationChannel:[I

    sget-object v1, Lcom/facebook/accountkit/ui/NotificationChannel;->FACEBOOK:Lcom/facebook/accountkit/ui/NotificationChannel;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/NotificationChannel;->ordinal()I

    move-result v1

    const/4 v2, 0x1

    aput v2, v0, v1
    :try_end_0
    .catch Ljava/lang/NoSuchFieldError; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    sget-object v0, Lcom/facebook/accountkit/ui/LoginConfirmationCodeContentController$2;->$SwitchMap$com$facebook$accountkit$ui$NotificationChannel:[I

    sget-object v1, Lcom/facebook/accountkit/ui/NotificationChannel;->VOICE_CALLBACK:Lcom/facebook/accountkit/ui/NotificationChannel;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/NotificationChannel;->ordinal()I

    move-result v1

    const/4 v2, 0x2

    aput v2, v0, v1
    :try_end_1
    .catch Ljava/lang/NoSuchFieldError; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method
