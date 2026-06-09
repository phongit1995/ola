.class public final enum Lcom/facebook/accountkit/ui/ButtonType;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/facebook/accountkit/ui/ButtonType;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/facebook/accountkit/ui/ButtonType;

.field public static final enum BEGIN:Lcom/facebook/accountkit/ui/ButtonType;

.field public static final enum CONFIRM:Lcom/facebook/accountkit/ui/ButtonType;

.field public static final enum CONTINUE:Lcom/facebook/accountkit/ui/ButtonType;

.field public static final enum LOG_IN:Lcom/facebook/accountkit/ui/ButtonType;

.field public static final enum NEXT:Lcom/facebook/accountkit/ui/ButtonType;

.field public static final enum OK:Lcom/facebook/accountkit/ui/ButtonType;

.field public static final enum SEND:Lcom/facebook/accountkit/ui/ButtonType;

.field public static final enum START:Lcom/facebook/accountkit/ui/ButtonType;

.field public static final enum SUBMIT:Lcom/facebook/accountkit/ui/ButtonType;


# instance fields
.field private final value:I


# direct methods
.method static constructor <clinit>()V
    .locals 12

    new-instance v0, Lcom/facebook/accountkit/ui/ButtonType;

    const-string v1, "BEGIN"

    sget v2, Lcom/facebook/accountkit/R$string;->com_accountkit_button_begin:I

    const/4 v3, 0x0

    invoke-direct {v0, v1, v3, v2}, Lcom/facebook/accountkit/ui/ButtonType;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/facebook/accountkit/ui/ButtonType;->BEGIN:Lcom/facebook/accountkit/ui/ButtonType;

    new-instance v0, Lcom/facebook/accountkit/ui/ButtonType;

    const-string v1, "CONFIRM"

    sget v2, Lcom/facebook/accountkit/R$string;->com_accountkit_button_confirm:I

    const/4 v4, 0x1

    invoke-direct {v0, v1, v4, v2}, Lcom/facebook/accountkit/ui/ButtonType;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/facebook/accountkit/ui/ButtonType;->CONFIRM:Lcom/facebook/accountkit/ui/ButtonType;

    new-instance v0, Lcom/facebook/accountkit/ui/ButtonType;

    const-string v1, "CONTINUE"

    sget v2, Lcom/facebook/accountkit/R$string;->com_accountkit_button_continue:I

    const/4 v5, 0x2

    invoke-direct {v0, v1, v5, v2}, Lcom/facebook/accountkit/ui/ButtonType;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/facebook/accountkit/ui/ButtonType;->CONTINUE:Lcom/facebook/accountkit/ui/ButtonType;

    new-instance v0, Lcom/facebook/accountkit/ui/ButtonType;

    const-string v1, "LOG_IN"

    sget v2, Lcom/facebook/accountkit/R$string;->com_accountkit_button_log_in:I

    const/4 v6, 0x3

    invoke-direct {v0, v1, v6, v2}, Lcom/facebook/accountkit/ui/ButtonType;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/facebook/accountkit/ui/ButtonType;->LOG_IN:Lcom/facebook/accountkit/ui/ButtonType;

    new-instance v0, Lcom/facebook/accountkit/ui/ButtonType;

    const-string v1, "NEXT"

    sget v2, Lcom/facebook/accountkit/R$string;->com_accountkit_button_next:I

    const/4 v7, 0x4

    invoke-direct {v0, v1, v7, v2}, Lcom/facebook/accountkit/ui/ButtonType;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/facebook/accountkit/ui/ButtonType;->NEXT:Lcom/facebook/accountkit/ui/ButtonType;

    new-instance v0, Lcom/facebook/accountkit/ui/ButtonType;

    const-string v1, "OK"

    sget v2, Lcom/facebook/accountkit/R$string;->com_accountkit_button_ok:I

    const/4 v8, 0x5

    invoke-direct {v0, v1, v8, v2}, Lcom/facebook/accountkit/ui/ButtonType;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/facebook/accountkit/ui/ButtonType;->OK:Lcom/facebook/accountkit/ui/ButtonType;

    new-instance v0, Lcom/facebook/accountkit/ui/ButtonType;

    const-string v1, "SEND"

    sget v2, Lcom/facebook/accountkit/R$string;->com_accountkit_button_send:I

    const/4 v9, 0x6

    invoke-direct {v0, v1, v9, v2}, Lcom/facebook/accountkit/ui/ButtonType;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/facebook/accountkit/ui/ButtonType;->SEND:Lcom/facebook/accountkit/ui/ButtonType;

    new-instance v0, Lcom/facebook/accountkit/ui/ButtonType;

    const-string v1, "START"

    sget v2, Lcom/facebook/accountkit/R$string;->com_accountkit_button_start:I

    const/4 v10, 0x7

    invoke-direct {v0, v1, v10, v2}, Lcom/facebook/accountkit/ui/ButtonType;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/facebook/accountkit/ui/ButtonType;->START:Lcom/facebook/accountkit/ui/ButtonType;

    new-instance v0, Lcom/facebook/accountkit/ui/ButtonType;

    const-string v1, "SUBMIT"

    sget v2, Lcom/facebook/accountkit/R$string;->com_accountkit_button_submit:I

    const/16 v11, 0x8

    invoke-direct {v0, v1, v11, v2}, Lcom/facebook/accountkit/ui/ButtonType;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/facebook/accountkit/ui/ButtonType;->SUBMIT:Lcom/facebook/accountkit/ui/ButtonType;

    const/16 v0, 0x9

    new-array v0, v0, [Lcom/facebook/accountkit/ui/ButtonType;

    sget-object v1, Lcom/facebook/accountkit/ui/ButtonType;->BEGIN:Lcom/facebook/accountkit/ui/ButtonType;

    aput-object v1, v0, v3

    sget-object v1, Lcom/facebook/accountkit/ui/ButtonType;->CONFIRM:Lcom/facebook/accountkit/ui/ButtonType;

    aput-object v1, v0, v4

    sget-object v1, Lcom/facebook/accountkit/ui/ButtonType;->CONTINUE:Lcom/facebook/accountkit/ui/ButtonType;

    aput-object v1, v0, v5

    sget-object v1, Lcom/facebook/accountkit/ui/ButtonType;->LOG_IN:Lcom/facebook/accountkit/ui/ButtonType;

    aput-object v1, v0, v6

    sget-object v1, Lcom/facebook/accountkit/ui/ButtonType;->NEXT:Lcom/facebook/accountkit/ui/ButtonType;

    aput-object v1, v0, v7

    sget-object v1, Lcom/facebook/accountkit/ui/ButtonType;->OK:Lcom/facebook/accountkit/ui/ButtonType;

    aput-object v1, v0, v8

    sget-object v1, Lcom/facebook/accountkit/ui/ButtonType;->SEND:Lcom/facebook/accountkit/ui/ButtonType;

    aput-object v1, v0, v9

    sget-object v1, Lcom/facebook/accountkit/ui/ButtonType;->START:Lcom/facebook/accountkit/ui/ButtonType;

    aput-object v1, v0, v10

    sget-object v1, Lcom/facebook/accountkit/ui/ButtonType;->SUBMIT:Lcom/facebook/accountkit/ui/ButtonType;

    aput-object v1, v0, v11

    sput-object v0, Lcom/facebook/accountkit/ui/ButtonType;->$VALUES:[Lcom/facebook/accountkit/ui/ButtonType;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;II)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)V"
        }
    .end annotation

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput p3, p0, Lcom/facebook/accountkit/ui/ButtonType;->value:I

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/facebook/accountkit/ui/ButtonType;
    .locals 1

    const-class v0, Lcom/facebook/accountkit/ui/ButtonType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/facebook/accountkit/ui/ButtonType;

    return-object p0
.end method

.method public static values()[Lcom/facebook/accountkit/ui/ButtonType;
    .locals 1

    sget-object v0, Lcom/facebook/accountkit/ui/ButtonType;->$VALUES:[Lcom/facebook/accountkit/ui/ButtonType;

    invoke-virtual {v0}, [Lcom/facebook/accountkit/ui/ButtonType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/facebook/accountkit/ui/ButtonType;

    return-object v0
.end method


# virtual methods
.method public getValue()I
    .locals 1

    iget v0, p0, Lcom/facebook/accountkit/ui/ButtonType;->value:I

    return v0
.end method
